package snipeit

import (
	"context"
	"fmt"
	"net/http"

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

func (c *Client) GetUsers(ctx context.Context, offset, limit int, query ...queryFunction) (*UsersResponse, *http.Response, error) {
	url := fmt.Sprint(c.baseUrl, "/api/v1/users")

	req, err := c.newRequestWithDefaultHeaders(ctx, http.MethodGet, url)
	if err != nil {
		return nil, nil, err
	}

	query = append(query, WithOffset(offset), WithLimit(limit))

	addQueryParams(
		req,
		query...,
	)

	users := new(UsersResponse)
	resp, err := c.do(req, users)
	if err != nil {
		ctxzap.Extract(ctx).Error("Failed to get users", zap.Error(err))
		return nil, resp, err
	}

	return users, resp, nil
}

func (c *Client) GetUser(ctx context.Context, id int) (*User, *http.Response, error) {
	url := fmt.Sprintf("%s/api/v1/users/%d", c.baseUrl, id)

	req, err := c.newRequestWithDefaultHeaders(ctx, http.MethodGet, url)
	if err != nil {
		return nil, nil, err
	}

	user := new(User)
	resp, err := c.do(req, user)
	if err != nil {
		return nil, resp, err
	}

	return user, resp, nil
}
