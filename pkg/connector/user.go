package connector

import (
	"context"
	"fmt"
	"strconv"

	v2 "github.com/conductorone/baton-sdk/pb/c1/connector/v2"
	"github.com/conductorone/baton-sdk/pkg/annotations"
	"github.com/conductorone/baton-sdk/pkg/pagination"
	rs "github.com/conductorone/baton-sdk/pkg/types/resource"

	snipeit "github.com/conductorone/baton-snipe-it/pkg/snipe-it"
)

var resourceTypeUser = &v2.ResourceType{
	Id:          "user",
	DisplayName: "User",
	Description: "A user in Snipe-IT",
	Traits:      []v2.ResourceType_Trait{v2.ResourceType_TRAIT_USER},
	Annotations: getResourceTypeAnnotation(),
}

func getResourceTypeAnnotation() annotations.Annotations {
	annotations := annotations.Annotations{}
	annotations.Update(&v2.SkipEntitlementsAndGrants{})

	return annotations
}

type userResourceType struct {
	resourceType *v2.ResourceType
	client       *snipeit.Client
}

func (o *userResourceType) ResourceType(ctx context.Context) *v2.ResourceType {
	return o.resourceType
}

func userResource(ctx context.Context, user *snipeit.User) (*v2.Resource, error) {
	profile := map[string]interface{}{
		"first_name":      user.FirstName,
		"last_name":       user.LastName,
		"email":           user.Email,
		"login":           user.Username,
		"user_id":         strconv.Itoa(user.ID),
		"vip":             strconv.FormatBool(user.VIP),
		"activated":       strconv.FormatBool(user.Activated),
		"employee_number": user.EmployeeNumber,
	}

	userTraitOptions := []rs.UserTraitOption{
		rs.WithUserProfile(profile),
		rs.WithEmail(user.Email, true),
		rs.WithUserLogin(user.Username),
		rs.WithStatus(getUserStatus(user)),
	}

	fullName := fmt.Sprintf("%s %s", user.FirstName, user.LastName)
	resource, err := rs.NewUserResource(fullName, resourceTypeUser, user.ID, userTraitOptions)
	if err != nil {
		return nil, err
	}

	return resource, nil
}

func getUserStatus(u *snipeit.User) v2.UserTrait_Status_Status {
	if u.Activated {
		return v2.UserTrait_Status_STATUS_ENABLED
	}

	return v2.UserTrait_Status_STATUS_DISABLED
}

func (o *userResourceType) List(ctx context.Context, _ *v2.ResourceId, pt *pagination.Token) ([]*v2.Resource, string, annotations.Annotations, error) {
	bag, offset, err := parsePageToken(pt.Token, &v2.ResourceId{ResourceType: o.resourceType.Id})
	if err != nil {
		return nil, "", nil, err
	}

	users, err := o.client.GetUsers(ctx, offset, resourcePageSize)
	if err != nil {
		return nil, "", nil, wrapError(err, "Failed to get users")
	}

	var resources []*v2.Resource
	for _, user := range users.Rows {
		user := user
		resource, err := userResource(ctx, &user)
		if err != nil {
			return nil, "", nil, err
		}

		resources = append(resources, resource)
	}

	if isLastPage(len(users.Rows), resourcePageSize) {
		return resources, "", nil, nil
	}

	nextPage, err := handleNextPage(bag, offset+resourcePageSize)
	if err != nil {
		return nil, "", nil, err
	}

	return resources, nextPage, nil, nil
}

func (o *userResourceType) Entitlements(_ context.Context, resource *v2.Resource, _ *pagination.Token) ([]*v2.Entitlement, string, annotations.Annotations, error) {
	return nil, "", nil, nil
}

func (o *userResourceType) Grants(ctx context.Context, resource *v2.Resource, pToken *pagination.Token) ([]*v2.Grant, string, annotations.Annotations, error) {
	return nil, "", nil, nil
}

func newUserBuilder(client *snipeit.Client) *userResourceType {
	return &userResourceType{
		resourceType: resourceTypeUser,
		client:       client,
	}
}
