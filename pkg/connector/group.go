package connector

import (
	"context"
	"fmt"
	"strconv"

	v2 "github.com/conductorone/baton-sdk/pb/c1/connector/v2"
	"github.com/conductorone/baton-sdk/pkg/annotations"
	"github.com/conductorone/baton-sdk/pkg/pagination"
	ent "github.com/conductorone/baton-sdk/pkg/types/entitlement"
	"github.com/conductorone/baton-sdk/pkg/types/grant"
	rs "github.com/conductorone/baton-sdk/pkg/types/resource"
	"github.com/grpc-ecosystem/go-grpc-middleware/logging/zap/ctxzap"
	"go.uber.org/zap"

	snipeit "github.com/conductorone/baton-snipe-it/pkg/snipe-it"
)

var resourceTypeGroup = &v2.ResourceType{
	Id:          "group",
	DisplayName: "Group",
	Description: "A group in Snipe-IT",
	Traits:      []v2.ResourceType_Trait{v2.ResourceType_TRAIT_GROUP},
}

type groupResourceType struct {
	resourceType *v2.ResourceType
	client       *snipeit.Client
}

func (o *groupResourceType) ResourceType(ctx context.Context) *v2.ResourceType {
	return o.resourceType
}

func groupResource(ctx context.Context, group *snipeit.Group) (*v2.Resource, error) {
	profile := map[string]interface{}{
		"name":     group.Name,
		"group_id": group.ID,
	}

	groupTraitOptions := []rs.GroupTraitOption{
		rs.WithGroupProfile(profile),
	}
	resource, err := rs.NewGroupResource(group.Name, resourceTypeGroup, group.ID, groupTraitOptions)
	if err != nil {
		return nil, err
	}

	return resource, nil
}

func (g *groupResourceType) Entitlements(ctx context.Context, resource *v2.Resource, pagination *pagination.Token) ([]*v2.Entitlement, string, annotations.Annotations, error) {
	var rv []*v2.Entitlement

	assigmentOptions := []ent.EntitlementOption{
		ent.WithGrantableTo(resourceTypeUser),
		ent.WithDescription(fmt.Sprintf("Member of %s group", resource.DisplayName)),
		ent.WithDisplayName(fmt.Sprintf("%s group %s", resource.DisplayName, memberEntitlement)),
	}

	entitlement := ent.NewAssignmentEntitlement(resource, memberEntitlement, assigmentOptions...)
	rv = append(rv, entitlement)

	return rv, "", nil, nil
}

func (g *groupResourceType) Grants(ctx context.Context, resource *v2.Resource, pagination *pagination.Token) ([]*v2.Grant, string, annotations.Annotations, error) {
	annos := annotations.Annotations{}
	bag, offset, err := parsePageToken(pagination.Token, &v2.ResourceId{ResourceType: resourceTypeUser.Id})
	if err != nil {
		return nil, "", annos, err
	}

	groupID, err := strconv.Atoi(resource.Id.Resource)
	if err != nil {
		return nil, "", annos, err
	}

	users, rldata, err := g.client.GetUsers(ctx, offset, resourcePageSize, snipeit.WithGroupId(groupID))
	if rldata != nil {
		annos.Append(rldata)
	}
	if err != nil {
		return nil, "", annos, wrapError(err, "Failed to get users")
	}

	var rv []*v2.Grant
	for _, user := range users.Rows {
		if !user.Groups.ContainsGroup(groupID) {
			continue
		}

		user := user
		userResource, err := userResource(ctx, &user)
		if err != nil {
			return nil, "", annos, err
		}

		grant := grant.NewGrant(resource, memberEntitlement, userResource.Id)
		rv = append(rv, grant)
	}

	if isLastPage(len(users.Rows), resourcePageSize) {
		return rv, "", annos, nil
	}

	nextPage, err := handleNextPage(bag, offset+resourcePageSize)
	if err != nil {
		return nil, "", annos, err
	}

	return rv, nextPage, annos, nil
}

func newGroupBuilder(client *snipeit.Client) *groupResourceType {
	return &groupResourceType{
		resourceType: resourceTypeGroup,
		client:       client,
	}
}

func (g *groupResourceType) List(ctx context.Context, _ *v2.ResourceId, pt *pagination.Token) ([]*v2.Resource, string, annotations.Annotations, error) {
	annos := annotations.Annotations{}
	groups, rldata, err := g.client.GetAllGroups(ctx)
	if rldata != nil {
		annos.Append(rldata)
	}
	if err != nil {
		return nil, "", annos, err
	}

	var resources []*v2.Resource
	for _, group := range groups.Rows {
		group := group
		resource, err := groupResource(ctx, &group)
		if err != nil {
			return nil, "", annos, err
		}

		resources = append(resources, resource)
	}

	return resources, "", annos, nil
}

func (g *groupResourceType) Grant(ctx context.Context, principal *v2.Resource, entitlement *v2.Entitlement) (annotations.Annotations, error) {
	l := ctxzap.Extract(ctx)

	if principal.Id.ResourceType != resourceTypeUser.Id {
		err := fmt.Errorf("baton-snipe-it: only user can be granted to groups")

		l.Warn(
			err.Error(),
			zap.String("principal_type", principal.Id.ResourceType),
			zap.String("principal_id", principal.Id.Resource),
		)

		return nil, err
	}

	groupID, err := strconv.Atoi(entitlement.Resource.Id.Resource)
	if err != nil {
		err := wrapError(err, "baton-snipe-it: failed to parse group id")

		l.Error(
			err.Error(),
			zap.String("groupId", entitlement.Resource.Id.Resource),
		)

		return nil, err
	}

	userID, err := strconv.Atoi(principal.Id.Resource)
	if err != nil {
		err := wrapError(err, "baton-snipe-it: failed to parse user id")

		l.Error(
			err.Error(),
			zap.String("userId", principal.Id.Resource),
		)
	}

	err = g.client.AddUserToGroup(ctx, groupID, userID)
	if err != nil {
		err := wrapError(err, "baton-snipe-it: failed to add user to group")

		l.Error(
			err.Error(),
			zap.String("groupId", entitlement.Resource.Id.Resource),
			zap.String("userId", principal.Id.Resource),
		)
	}

	return nil, nil
}

func (g *groupResourceType) Revoke(ctx context.Context, grant *v2.Grant) (annotations.Annotations, error) {
	l := ctxzap.Extract(ctx)

	entitlement := grant.Entitlement
	principal := grant.Principal

	if principal.Id.ResourceType != resourceTypeUser.Id {
		err := fmt.Errorf("baton-snipe-it: only user can be revoked from groups")

		l.Warn(
			err.Error(),
			zap.String("principal_type", principal.Id.ResourceType),
			zap.String("principal_id", principal.Id.Resource),
		)

		return nil, err
	}

	groupID, err := strconv.Atoi(entitlement.Resource.Id.Resource)
	if err != nil {
		err := wrapError(err, "baton-snipe-it: failed to parse group id")

		l.Error(
			err.Error(),
			zap.String("groupId", entitlement.Resource.Id.Resource),
		)

		return nil, err
	}

	userID, err := strconv.Atoi(principal.Id.Resource)
	if err != nil {
		err := wrapError(err, "baton-snipe-it: failed to parse user id")

		l.Error(
			err.Error(),
			zap.String("userId", principal.Id.Resource),
		)
	}

	err = g.client.RemoveUserFromGroup(ctx, groupID, userID)
	if err != nil {
		err := wrapError(err, "baton-snipe-it: failed to remove user from group")

		l.Error(
			err.Error(),
			zap.String("groupId", entitlement.Resource.Id.Resource),
			zap.String("userId", principal.Id.Resource),
		)
	}

	return nil, nil
}
