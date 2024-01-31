package snipeit

import (
	"context"
	"fmt"
	"net/http"
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
	url := fmt.Sprint(c.baseUrl, "/api/v1/groups")

	req, err := c.newRequestWithDefaultHeaders(ctx, http.MethodGet, url)
	if err != nil {
		return nil, err
	}

	groups := new(GroupsResponse)
	err = c.do(req, groups)
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

	url := fmt.Sprintf("%s/api/v1/users/%d", c.baseUrl, userId)

	var body = PatchUserBody{
		Groups: []int{groupId},
	}

	for _, group := range user.Groups.Rows {
		body.Groups = append(body.Groups, group.ID)
	}

	req, err := c.newRequestWithDefaultHeaders(ctx, http.MethodPatch, url, body)
	if err != nil {
		return err
	}

	err = c.do(req, nil)
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

	url := fmt.Sprintf("%s/api/v1/users/%d", c.baseUrl, userId)

	var body = PatchUserBody{
		Groups: []int{},
	}

	for _, group := range user.Groups.Rows {
		if group.ID != groupId {
			body.Groups = append(body.Groups, group.ID)
		}
	}

	req, err := c.newRequestWithDefaultHeaders(ctx, http.MethodPatch, url, body)
	if err != nil {
		return err
	}

	err = c.do(req, nil)
	if err != nil {
		return err
	}

	return nil
}
