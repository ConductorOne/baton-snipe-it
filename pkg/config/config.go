package config

import (
	"github.com/conductorone/baton-sdk/pkg/field"
)

var (
	BaseUrlField = field.StringField(
		"base-url",
		field.WithDescription("Base URL for the snipe-it instance"),
		field.WithRequired(true),
	)

	AccessTokenField = field.StringField(
		"access-token",
		field.WithDescription("API key for the snipe-it instance"),
		field.WithIsSecret(true),
		field.WithRequired(true),
	)

	ConfigurationFields = []field.SchemaField{
		BaseUrlField,
		AccessTokenField,
	}

	ConfigurationSchema = field.Configuration{
		Fields: ConfigurationFields,
	}
)

//go:generate go run ./gen
var Config = field.NewConfiguration(ConfigurationFields)
