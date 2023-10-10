package snipeit

import (
	"context"
	"fmt"
	"net/http"
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
	}

	UsersResponse struct {
		Total int    `json:"total"`
		Rows  []User `json:"rows"`
	}
)

func (c *Client) GetAllUsers(ctx context.Context, offset, limit int) (*UsersResponse, *http.Response, error) {
	url := fmt.Sprint(c.baseUrl, "/api/v1/users")

	req, err := c.newRequestWithDefaultHeaders(ctx, http.MethodGet, url)
	if err != nil {
		return nil, nil, err
	}

	addQueryParams(req, map[string]string{
		"offset": fmt.Sprint(offset),
		"limit":  fmt.Sprint(limit),
	})

	users := new(UsersResponse)
	resp, err := c.do(req, users)
	if err != nil {
		return nil, resp, err
	}

	return users, resp, nil
}
