package connector

import (
	"context"
	"io"

	v2 "github.com/conductorone/baton-sdk/pb/c1/connector/v2"
	"github.com/conductorone/baton-sdk/pkg/annotations"
	"github.com/conductorone/baton-sdk/pkg/connectorbuilder"
	"github.com/conductorone/baton-sdk/pkg/uhttp"
	snipeit "github.com/conductorone/baton-snipe-it/pkg/snipe-it"
)

type SnipeIt struct {
	client *snipeit.Client
}

// ResourceSyncers returns a ResourceSyncer for each resource type that should be synced from the upstream service.
func (d *SnipeIt) ResourceSyncers(ctx context.Context) []connectorbuilder.ResourceSyncer {
	return []connectorbuilder.ResourceSyncer{
		newUserBuilder(d.client),
		newGroupBuilder(d.client),
		newRoleBuilder(d.client),
	}
}

// Asset takes an input AssetRef and attempts to fetch it using the connector's authenticated http client
// It streams a response, always starting with a metadata object, following by chunked payloads for the asset.
func (d *SnipeIt) Asset(ctx context.Context, asset *v2.AssetRef) (string, io.ReadCloser, error) {
	return "", nil, nil
}

// Metadata returns metadata about the connector.
func (d *SnipeIt) Metadata(ctx context.Context) (*v2.ConnectorMetadata, error) {
	return &v2.ConnectorMetadata{
		DisplayName: "Snipe-IT",
		Description: "Connector syncing Snipe-IT users and their groups to Baton.",
	}, nil
}

// Validate is called to ensure that the connector is properly configured. It should exercise any API credentials
// to be sure that they are valid.
func (d *SnipeIt) Validate(ctx context.Context) (annotations.Annotations, error) {
	_, _, err := d.client.GetUsers(ctx, 0, 1)
	if err != nil {
		return nil, wrapError(err, "Not enough permissions to get users")
	}

	return nil, nil
}

// New returns a new instance of the connector.
func New(ctx context.Context, baseUrl string, accessToken string) (*SnipeIt, error) {
	httpClient, err := uhttp.NewClient(
		ctx,
		uhttp.WithLogger(true, nil),
		uhttp.WithUserAgent("baton-snipe-it"),
	)
	if err != nil {
		return nil, err
	}

	return &SnipeIt{
		client: snipeit.New(baseUrl, accessToken, httpClient),
	}, nil
}
