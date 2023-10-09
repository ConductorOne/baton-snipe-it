package snipeit

import (
	"context"
	"encoding/json"
	"net/http"
)

type (
	Client struct {
		httpClient  *http.Client
		accessToken string
		baseUrl     string
	}
)

func New(baseUrl string, accessToken string, httpClient *http.Client) *Client {
	return &Client{
		httpClient:  httpClient,
		accessToken: accessToken,
		baseUrl:     baseUrl,
	}
}

func (c *Client) newRequestWithDefaultHeaders(ctx context.Context, method, url string) (*http.Request, error) {
	req, err := http.NewRequestWithContext(ctx, method, url, nil)
	if err != nil {
		return nil, err
	}

	req.Header.Add("Authorization", "Bearer "+c.accessToken)
	req.Header.Add("Accept", "application/json")
	req.Header.Add("Content-Type", "application/json")

	return req, nil
}

func (c *Client) do(req *http.Request, response interface{}) (*http.Response, error) {
	resp, err := c.httpClient.Do(req)
	if err != nil {
		return nil, err
	}

	if resp.StatusCode < 200 && resp.StatusCode < 300 {
		return nil, newSnipeItError(resp.StatusCode, err)
	}

	defer resp.Body.Close()
	err = json.NewDecoder(resp.Body).Decode(response)

	return resp, err
}

func addQueryParams(req *http.Request, params map[string]string) *http.Request {
	q := req.URL.Query()
	for key, value := range params {
		q.Add(key, value)
	}
	req.URL.RawQuery = q.Encode()

	return req
}
