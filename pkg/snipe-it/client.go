package snipeit

import (
	"bytes"
	"context"
	"encoding/json"
	"errors"
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

func (c *Client) do(req *http.Request, response interface{}) error {
	resp, err := c.httpClient.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	if resp.StatusCode < 200 || resp.StatusCode >= 300 {
		out, err2 := io.ReadAll(resp.Body)
		return errors.Join(err, err2, fmt.Errorf("unexpected status code: %d. body: %s", resp.StatusCode, string(out)))
	}

	if response != nil {
		err = json.NewDecoder(resp.Body).Decode(response)
		if err != nil {
			return err
		}
	}

	return err
}
