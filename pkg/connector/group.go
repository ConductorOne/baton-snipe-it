package connector

import (
	"context"
	"fmt"
	"strconv"

	v2 "github.com/conductorone/baton-sdk/pb/c1/connector/v2"
	"github.com/conductorone/baton-sdk/pkg/annotations"
	"github.com/conductorone/baton-sdk/pkg/pagination"
	ent "github.com/conductorone/baton-sdk/pkg/types/entitlement"
	grant "github.com/conductorone/baton-sdk/pkg/types/grant"
	rs "github.com/conductorone/baton-sdk/pkg/types/resource"
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
	bag, offset, err := parsePageToken(pagination.Token, &v2.ResourceId{ResourceType: resourceTypeUser.Id})
	if err != nil {
		return nil, "", nil, err
	}

	users, _, err := g.client.GetAllUsers(ctx, offset, resourcePageSize)
	if err != nil {
		return nil, "", nil, wrapError(err, "Failed to get users")
	}

	var rv []*v2.Grant
	for _, user := range users.Rows {
		groupID, err := strconv.Atoi(resource.Id.Resource)
		if err != nil {
			return nil, "", nil, err
		}
		if !user.Groups.ContainsGroup(groupID) {
			continue
		}

		user := user
		userResource, err := userResource(ctx, &user)
		if err != nil {
			return nil, "", nil, err
		}

		grant := grant.NewGrant(resource, memberEntitlement, userResource.Id)
		rv = append(rv, grant)
	}

	if isLastPage(len(users.Rows), resourcePageSize) {
		return rv, "", nil, nil
	}

	nextPage, err := handleNextPage(bag, offset+resourcePageSize)
	if err != nil {
		return nil, "", nil, err
	}

	return rv, nextPage, nil, nil
}

func newGroupBuilder(client *snipeit.Client) *groupResourceType {
	return &groupResourceType{
		resourceType: resourceTypeGroup,
		client:       client,
	}
}

func (g *groupResourceType) List(ctx context.Context, _ *v2.ResourceId, _ *pagination.Token) ([]*v2.Resource, string, annotations.Annotations, error) {
	groups, _, err := g.client.GetAllGroups(ctx)
	if err != nil {
		return nil, "", nil, err
	}

	var resources []*v2.Resource
	for _, group := range groups.Rows {
		group := group
		resource, err := groupResource(ctx, &group)
		if err != nil {
			return nil, "", nil, err
		}

		resources = append(resources, resource)
	}

	return resources, "", nil, nil
}
