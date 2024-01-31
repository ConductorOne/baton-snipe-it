package connector

import (
	"context"
	"fmt"
	"strings"

	v2 "github.com/conductorone/baton-sdk/pb/c1/connector/v2"
	"github.com/conductorone/baton-sdk/pkg/annotations"
	"github.com/conductorone/baton-sdk/pkg/pagination"
	ent "github.com/conductorone/baton-sdk/pkg/types/entitlement"
	"github.com/conductorone/baton-sdk/pkg/types/grant"
	rs "github.com/conductorone/baton-sdk/pkg/types/resource"

	snipeit "github.com/conductorone/baton-snipe-it/pkg/snipe-it"
)

var (
	resourceTypeRole = &v2.ResourceType{
		Id:          "role",
		DisplayName: "Role",
		Description: "A role in Snipe-IT",
		Traits:      []v2.ResourceType_Trait{v2.ResourceType_TRAIT_ROLE},
	}

	roles      = []string{"Superuser", "Admin", "Other"}
	adminRoles = []string{"Superuser", "Admin"}

	rolesLowerCase      = Map(roles, strings.ToLower)
	adminRolesLowerCase = Map(adminRoles, strings.ToLower)
)

type roleResourceType struct {
	resourceType *v2.ResourceType
	client       *snipeit.Client
}

func (r *roleResourceType) ResourceType(ctx context.Context) *v2.ResourceType {
	return r.resourceType
}

func roleResource(ctx context.Context, role string) (*v2.Resource, error) {
	profile := map[string]interface{}{
		"name": role,
	}

	roleTraitOptions := []rs.RoleTraitOption{
		rs.WithRoleProfile(profile),
	}

	resource, err := rs.NewRoleResource(role, resourceTypeRole, role, roleTraitOptions)
	if err != nil {
		return nil, err
	}

	return resource, nil
}

func (r *roleResourceType) Entitlements(ctx context.Context, resource *v2.Resource, pagination *pagination.Token) ([]*v2.Entitlement, string, annotations.Annotations, error) {
	bag, offset, err := parsePageToken(
		pagination.Token,
		&v2.ResourceId{ResourceType: resourceTypeUser.Id},
	)
	if err != nil {
		return nil, "", nil, err
	}

	var rv []*v2.Entitlement

	if isAdminRole(resource.Id.Resource) {
		rv = append(rv, r.getAppointedEntitlement(resource)...)

		return rv, "", nil, nil
	}

	if offset == 0 {
		// Groups doesn't have pagination, so we need to get all groups and iterate over them just once
		groups, err := r.client.GetAllGroups(ctx)
		if err != nil {
			return nil, "", nil, wrapError(err, "Failed to get groups")
		}

		for _, group := range groups.Rows {
			entitlements, err := r.getPermissionEntitlements(group.Permissions, resource, resourceTypeGroup)
			if err != nil {
				return nil, "", nil, wrapError(err, "Failed to get group permissions")
			}

			rv = append(rv, entitlements...)
		}
	}

	users, err := r.client.GetUsers(ctx, offset, resourcePageSize)
	if err != nil {
		return nil, "", nil, wrapError(err, "Failed to get users")
	}

	for _, user := range users.Rows {
		entitlements, err := r.getPermissionEntitlements(user.Permissions, resource, resourceTypeUser)
		if err != nil {
			return nil, "", nil, wrapError(err, "Failed to get user permissions")
		}

		rv = append(rv, entitlements...)
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

func (r *roleResourceType) getPermissionEntitlements(permissions snipeit.Permissions, resource *v2.Resource, resourceType *v2.ResourceType) ([]*v2.Entitlement, error) {
	var rv []*v2.Entitlement

	if isAdminRole(resource.Id.Resource) {
		return rv, nil
	}

	for permission, value := range permissions {
		if value != snipeit.Granted || isRole(permission) {
			continue
		}

		entitlementName, err := composePermissionEntitlementName(permission)
		if err != nil {
			return nil, err
		}

		assigmentOptions := []ent.EntitlementOption{
			ent.WithGrantableTo(resourceType),
			ent.WithDescription(fmt.Sprintf("can %s", entitlementName)),
			ent.WithDisplayName(fmt.Sprintf("%s %s", resource.DisplayName, entitlementName)),
		}

		entitlement := ent.NewPermissionEntitlement(resource, entitlementName, assigmentOptions...)
		rv = append(rv, entitlement)
	}

	return rv, nil
}

func composePermissionEntitlementName(permission string) (string, error) {
	entity, action, err := parsePermission(permission)
	if err != nil {
		return "", err
	}

	return fmt.Sprintf("%s %s", action, entity), nil
}

func parsePermission(permission string) (string, string, error) {
	parts := strings.Split(permission, ".")
	if len(parts) < 2 {
		return "", "", fmt.Errorf("invalid permission: %s", permission)
	}

	return parts[0], parts[1], nil
}

func isRole(input string) bool {
	return contains(rolesLowerCase, strings.ToLower(input))
}

func isAdminRole(role string) bool {
	return contains(adminRolesLowerCase, strings.ToLower(role))
}

func (r *roleResourceType) getAppointedEntitlement(resource *v2.Resource) []*v2.Entitlement {
	var rv []*v2.Entitlement

	assigmentOptions := []ent.EntitlementOption{
		ent.WithGrantableTo(resourceTypeUser),
		ent.WithDescription(fmt.Sprintf("Appointed to %s role", resource.DisplayName)),
		ent.WithDisplayName(fmt.Sprintf("%s role %s", resource.DisplayName, assignedEntitlement)),
	}

	entitlement := ent.NewAssignmentEntitlement(resource, assignedEntitlement, assigmentOptions...)
	rv = append(rv, entitlement)

	assigmentOptions = []ent.EntitlementOption{
		ent.WithGrantableTo(resourceTypeGroup),
		ent.WithDescription(fmt.Sprintf("Appointed to %s role", resource.DisplayName)),
		ent.WithDisplayName(fmt.Sprintf("%s role %s", resource.DisplayName, assignedEntitlement)),
	}

	entitlement = ent.NewAssignmentEntitlement(resource, assignedEntitlement, assigmentOptions...)
	rv = append(rv, entitlement)

	return rv
}

func (r *roleResourceType) Grants(ctx context.Context, resource *v2.Resource, pagination *pagination.Token) ([]*v2.Grant, string, annotations.Annotations, error) {
	bag, offset, err := parsePageToken(
		pagination.Token,
		&v2.ResourceId{ResourceType: resourceTypeUser.Id},
	)
	if err != nil {
		return nil, "", nil, err
	}

	var rv []*v2.Grant

	if offset == 0 {
		// Groups doesn't have pagination, so we need to get all groups and iterate over them just once
		groups, err := r.client.GetAllGroups(ctx)
		if err != nil {
			return nil, "", nil, wrapError(err, "Failed to get groups")
		}

		for _, group := range groups.Rows {
			group := group
			groupResource, err := groupResource(ctx, &group)
			if err != nil {
				return nil, "", nil, wrapError(err, "Failed to get group resource")
			}

			grants, err := r.getGrantsFromPermissions(group.Permissions, resource, groupResource)
			if err != nil {
				return nil, "", nil, wrapError(err, "Failed to get group grants")
			}

			rv = append(rv, grants...)
		}
	}

	users, err := r.client.GetUsers(ctx, offset, resourcePageSize)
	if err != nil {
		return nil, "", nil, wrapError(err, "Failed to get users")
	}

	for _, user := range users.Rows {
		user := user
		userResource, err := userResource(ctx, &user)
		if err != nil {
			return nil, "", nil, wrapError(err, "Failed to get user resource")
		}

		grants, err := r.getGrantsFromPermissions(user.Permissions, resource, userResource)
		if err != nil {
			return nil, "", nil, wrapError(err, "Failed to get user grants")
		}

		rv = append(rv, grants...)
	}

	if isLastPage(len(users.Rows), resourcePageSize) {
		return rv, "", nil, nil
	}

	nextPage, err := handleNextPage(bag, offset+resourcePageSize)
	if err != nil {
		return nil, "", nil, err
	}

	return nil, nextPage, nil, nil
}

func (r *roleResourceType) getGrantsFromPermissions(permissions snipeit.Permissions, roleResource *v2.Resource, resource *v2.Resource) ([]*v2.Grant, error) {
	var rv []*v2.Grant

	if isAdminRole(roleResource.Id.Resource) {
		return grantAdminRole(permissions, roleResource, resource), nil
	}

	for permission, value := range permissions {
		if value != snipeit.Granted || isRole(permission) {
			continue
		}

		entitlementName, err := composePermissionEntitlementName(permission)
		if err != nil {
			return nil, err
		}

		grant := grant.NewGrant(roleResource, entitlementName, resource.Id)
		rv = append(rv, grant)
	}

	return rv, nil
}

func grantAdminRole(permissions snipeit.Permissions, roleResource *v2.Resource, resource *v2.Resource) []*v2.Grant {
	var rv []*v2.Grant

	if isGranted, exists := permissions[strings.ToLower(roleResource.Id.Resource)]; exists && isGranted == snipeit.Granted {
		grant := grant.NewGrant(roleResource, assignedEntitlement, resource.Id)
		rv = append(rv, grant)
	}

	return rv
}

func newRoleBuilder(client *snipeit.Client) *roleResourceType {
	return &roleResourceType{
		resourceType: resourceTypeRole,
		client:       client,
	}
}

func (r *roleResourceType) List(ctx context.Context, _ *v2.ResourceId, pagination *pagination.Token) ([]*v2.Resource, string, annotations.Annotations, error) {
	var rv []*v2.Resource

	for _, role := range roles {
		resource, err := roleResource(ctx, role)
		if err != nil {
			return nil, "", nil, err
		}

		rv = append(rv, resource)
	}

	return rv, "", nil, nil
}
