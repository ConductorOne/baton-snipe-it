package snipeit

import (
	"context"
	"io"
	"net/http"
	"net/url"
	"strings"

	"github.com/conductorone/baton-sdk/pkg/uhttp"
	"github.com/grpc-ecosystem/go-grpc-middleware/logging/zap/ctxzap"
	"go.uber.org/zap"
)

type (
	Client struct {
		uhttp.BaseHttpClient

		baseUrl string
	}
)

func New(baseUrl string, httpClient *http.Client) *Client {
	return &Client{
		BaseHttpClient: *uhttp.NewBaseHttpClient(httpClient),
		baseUrl:        baseUrl,
	}
}

func (c *Client) Validate(ctx context.Context) error {
	stringUrl, err := url.JoinPath(c.baseUrl, "api/v1/users")
	if err != nil {
		return err
	}

	u, err := url.Parse(stringUrl)
	if err != nil {
		return err
	}

	req, err := c.NewRequest(ctx, http.MethodGet, u)
	if err != nil {
		return err
	}

	query := []queryFunction{WithOffset(0), WithLimit(1)}

	addQueryParams(
		req,
		query...,
	)

	res, err := c.Do(req)
	if err != nil {
		baseUrl := strings.TrimSuffix(c.baseUrl, "/")
		if res.StatusCode == 404 && strings.HasSuffix(baseUrl, "api/v1") {
			c.baseUrl = strings.TrimSuffix(baseUrl, "api/v1")
			return c.Validate(ctx)
		}

		bodyBytes, err := io.ReadAll(res.Body)
		if err != nil {
			return err
		}
		bodyString := string(bodyBytes)

		ctxzap.Extract(ctx).Error("Failed to validate API", zap.Error(err), zap.Any("response", res), zap.String("body", bodyString))
		return err
	}
	defer res.Body.Close()

	return nil
}
