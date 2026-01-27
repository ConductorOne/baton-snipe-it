package main

import (
	cfg "github.com/conductorone/baton-snipe-it/pkg/config"
	"github.com/conductorone/baton-sdk/pkg/config"
)

func main() {
	config.Generate("snipe-it", cfg.Config)
}
