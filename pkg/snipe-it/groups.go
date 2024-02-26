package snipeit

import (
	"context"
	"fmt"
	"net/http"
	"net/url"

	"github.com/conductorone/baton-sdk/pkg/uhttp"
)

type (
	Group struct {
		ID          int         `json:"id"`
		Name        string      `json:"name"`
		Permissions Permissions `json:"permissions"`
	}

	GroupsResponse struct {
		Total int     `json:"total"`
		Rows  []Group `json:"rows"`
	}
)

func (c *Client) GetAllGroups(ctx context.Context) (*GroupsResponse, error) {
	stringUrl, err := url.JoinPath(c.baseUrl, "api/v1/groups")
	if err != nil {
		return nil, err
	}

	u, err := url.Parse(stringUrl)
	if err != nil {
		return nil, err
	}

	req, err := c.NewRequest(ctx, http.MethodGet, u)
	if err != nil {
		return nil, err
	}

	groups := new(GroupsResponse)
	_, err = c.Do(req, uhttp.WithJSONResponse(groups))
	if err != nil {
		return nil, err
	}

	return groups, nil
}

func (x GroupsResponse) ContainsGroup(id int) bool {
	for _, group := range x.Rows {
		if group.ID == id {
			return true
		}
	}

	return false
}

func (c *Client) AddUserToGroup(ctx context.Context, groupId int, userId int) error {
	user, err := c.GetUser(ctx, userId)
	if err != nil {
		return err
	}

	stringUrl, err := url.JoinPath(c.baseUrl, "api/v1/users", fmt.Sprintf("%d", userId))
	if err != nil {
		return err
	}

	u, err := url.Parse(stringUrl)
	if err != nil {
		return err
	}

	var body = PatchUserBody{
		Groups: []int{groupId},
	}

	for _, group := range user.Groups.Rows {
		body.Groups = append(body.Groups, group.ID)
	}

	req, err := c.NewRequest(ctx, http.MethodPatch, u, uhttp.WithJSONBody(body))
	if err != nil {
		return err
	}

	_, err = c.Do(req)
	if err != nil {
		return err
	}

	return nil
}

func (c *Client) RemoveUserFromGroup(ctx context.Context, groupId int, userId int) error {
	user, err := c.GetUser(ctx, userId)
	if err != nil {
		return err
	}

	stringUrl, err := url.JoinPath(c.baseUrl, "api/v1/users", fmt.Sprintf("%d", userId))
	if err != nil {
		return err
	}

	u, err := url.Parse(stringUrl)
	if err != nil {
		return err
	}

	var body = PatchUserBody{
		Groups: []int{},
	}

	for _, group := range user.Groups.Rows {
		if group.ID != groupId {
			body.Groups = append(body.Groups, group.ID)
		}
	}

	req, err := c.NewRequest(ctx, http.MethodPatch, u, uhttp.WithJSONBody(body))
	if err != nil {
		return err
	}

	_, err = c.Do(req)
	if err != nil {
		return err
	}

	return nil
}
