package snipeit

import (
	"net/http"

	"github.com/conductorone/baton-sdk/pkg/uhttp"
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
