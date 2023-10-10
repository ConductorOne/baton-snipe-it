package snipeit

import (
	"context"
	"fmt"
	"net/http"
)

type (
	Group struct {
		ID   int    `json:"id"`
		Name string `json:"name"`
	}

	GroupsResponse struct {
		Total int     `json:"total"`
		Rows  []Group `json:"rows"`
	}
)

func (c *Client) GetAllGroups(ctx context.Context) (*GroupsResponse, *http.Response, error) {
	url := fmt.Sprint(c.baseUrl, "/api/v1/groups")

	req, err := c.newRequestWithDefaultHeaders(ctx, http.MethodGet, url)
	if err != nil {
		return nil, nil, err
	}

	groups := new(GroupsResponse)
	resp, err := c.do(req, groups)
	if err != nil {
		return nil, resp, err
	}

	return groups, resp, nil
}

func (x GroupsResponse) ContainsGroup(id int) bool {
	for _, group := range x.Rows {
		if group.ID == id {
			return true
		}
	}

	return false
}
