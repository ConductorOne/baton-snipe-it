package snipeit

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
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

func (c *Client) newRequestWithDefaultHeaders(ctx context.Context, method, url string, body ...interface{}) (*http.Request, error) {
	var buffer io.ReadWriter
	if body != nil {
		buffer = new(bytes.Buffer)
		err := json.NewEncoder(buffer).Encode(body[0])

		if err != nil {
			return nil, err
		}
	}

	req, err := http.NewRequestWithContext(ctx, method, url, buffer)
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
	defer resp.Body.Close()

	if resp.StatusCode < 200 || resp.StatusCode >= 300 {
		return nil, newSnipeItError(resp.StatusCode, err)
	}

	if response != nil {
		body, err := io.ReadAll(resp.Body)
		if err != nil {
			return nil, err
		}
		resp.Body = io.NopCloser(bytes.NewBuffer(body))

		fmt.Println(string(body))

		err = json.Unmarshal(body, response)
		if err != nil {
			return nil, err
		}
	}

	return resp, err
}
