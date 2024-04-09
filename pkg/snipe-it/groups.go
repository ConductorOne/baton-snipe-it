package snipeit

import (
	"context"
	"fmt"
	"net/http"
	"net/url"

	v2 "github.com/conductorone/baton-sdk/pb/c1/connector/v2"
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

func (c *Client) GetAllGroups(ctx context.Context) (*GroupsResponse, *v2.RateLimitDescription, error) {
	stringUrl, err := url.JoinPath(c.baseUrl, "api/v1/groups")
	if err != nil {
		return nil, nil, err
	}

	u, err := url.Parse(stringUrl)
	if err != nil {
		return nil, nil, err
	}

	req, err := c.NewRequest(ctx, http.MethodGet, u, uhttp.WithAcceptJSONHeader())
	if err != nil {
		return nil, nil, err
	}

	groups := new(GroupsResponse)
	var rldata v2.RateLimitDescription
	res, err := c.Do(req, uhttp.WithRatelimitData(&rldata), uhttp.WithJSONResponse(groups))
	if res != nil {
		defer res.Body.Close()
		if res.StatusCode == http.StatusTooManyRequests {
			return groups, &rldata, nil
		}
	}
	if err != nil {
		return nil, &rldata, err
	}

	return groups, &rldata, nil
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

	res, err := c.Do(req)
	if err != nil {
		return err
	}
	defer res.Body.Close()

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

	res, err := c.Do(req)
	if err != nil {
		return err
	}
	defer res.Body.Close()

	return nil
}
