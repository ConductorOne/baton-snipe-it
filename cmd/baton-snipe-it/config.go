package main

import (
	"context"
	"fmt"

	"github.com/conductorone/baton-sdk/pkg/cli"
	"github.com/spf13/cobra"
)

// config defines the external configuration required for the connector to run.
type config struct {
	cli.BaseConfig `mapstructure:",squash"` // Puts the base config options in the same place as the connector options

	BaseUrl     string `mapstructure:"base-url"`
	AccessToken string `mapstructure:"access-token"`
}

// validateConfig is run after the configuration is loaded, and should return an error if it isn't valid.
func validateConfig(ctx context.Context, cfg *config) error {
	if cfg.BaseUrl == "" {
		return fmt.Errorf("base-url is required")
	}
	if cfg.AccessToken == "" {
		return fmt.Errorf("api-key is required")
	}
	return nil
}

func cmdFlags(cmd *cobra.Command) {
	cmd.PersistentFlags().String("base-url", "", "Base URL for the snipe-it instance")
	cmd.PersistentFlags().String("access-token", "", "API key for the snipe-it instance")
}
