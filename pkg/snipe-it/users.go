package snipeit

import (
	"context"
	"fmt"
	"net/http"
	"net/url"

	"github.com/conductorone/baton-sdk/pkg/uhttp"
	"github.com/grpc-ecosystem/go-grpc-middleware/logging/zap/ctxzap"
	"go.uber.org/zap"
)

type (
	User struct {
		ID             int            `json:"id"`
		Username       string         `json:"username"`
		FirstName      string         `json:"first_name"`
		LastName       string         `json:"last_name"`
		Email          string         `json:"email"`
		VIP            bool           `json:"vip"`
		EmployeeNumber string         `json:"employee_num"`
		Activated      bool           `json:"activated"`
		Groups         GroupsResponse `json:"groups"`
		Permissions    Permissions    `json:"permissions"`
	}

	UsersResponse struct {
		Total int64  `json:"total"`
		Rows  []User `json:"rows"`
	}

	PatchUserBody struct {
		Groups []int `json:"groups,omitempty" structs:"groups,omitempty"`
	}
)

func (c *Client) GetUsers(ctx context.Context, offset, limit int, query ...queryFunction) (*UsersResponse, error) {
	stringUrl, err := url.JoinPath(c.baseUrl, "api/v1/users")
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

	query = append(query, WithOffset(offset), WithLimit(limit))

	addQueryParams(
		req,
		query...,
	)

	users := new(UsersResponse)
	res, err := c.Do(req, uhttp.WithJSONResponse(users))
	if err != nil {
		ctxzap.Extract(ctx).Error("Failed to get users", zap.Error(err), zap.String("request_url", req.URL.String()))
		return nil, err
	}
	defer res.Body.Close()

	return users, nil
}

func (c *Client) GetUser(ctx context.Context, id int) (*User, error) {
	stringUrl, err := url.JoinPath(c.baseUrl, "api/v1/users", fmt.Sprintf("%d", id))
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

	user := new(User)
	res, err := c.Do(req, uhttp.WithJSONResponse(user))
	if err != nil {
		return nil, err
	}
	defer res.Body.Close()

	return user, nil
}
