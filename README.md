![Baton Logo](./docs/images/baton-logo.png)

# `baton-snipe-it` [![Go Reference](https://pkg.go.dev/badge/github.com/conductorone/baton-snipe-it.svg)](https://pkg.go.dev/github.com/conductorone/baton-snipe-it) ![main ci](https://github.com/conductorone/baton-snipe-it/actions/workflows/main.yaml/badge.svg)

`baton-snipe-it` is a connector for Baton built using the [Baton SDK](https://github.com/conductorone/baton-sdk). It works with Snipe-IT V6 API.

Check out [Baton](https://github.com/conductorone/baton) to learn more about the project in general.

# Prerequisites

Connector requires bearer access token that is used throughout the communication with API. To obtain this token, you have to create one in Snipe-IT. More in information about how to generate token [here](https://snipe-it.readme.io/reference/generating-api-tokens)). 

After you have obtained access token, you can use it with connector. You can do this by setting `BATON_ACCESS_TOKEN` or by passing `--access-token`.

# Getting Started

Along with access token, you must specify Snipe-IT URL that you want to use. You can change this by setting `BATON_BASE_URL` environment variable or by passing `--base-url` flag to `baton-snipe-it` command.

## brew

```
brew install conductorone/baton/baton conductorone/baton/baton-snipe-it

BATON_ACCESS_TOKEN=token BATON_BASE_URL=https://develop.snipeitapp.com baton-snipe-it
baton resources
```

## docker

```
docker run --rm -v $(pwd):/out -e BATON_ACCESS_TOKEN=token BATON_BASE_URL=https://develop.snipeitapp.com ghcr.io/conductorone/baton-snipe-it:latest -f "/out/sync.c1z"
docker run --rm -v $(pwd):/out ghcr.io/conductorone/baton:latest -f "/out/sync.c1z" resources
```

## source

```
go install github.com/conductorone/baton/cmd/baton@main
go install github.com/conductorone/baton-snipe-it/cmd/baton-snipe-it@main

BATON_ACCESS_TOKEN=token BATON_BASE_URL=https://develop.snipeitapp.com baton-snipe-it
baton resources
```

# Data Model

`baton-snipe-it` will fetch information about the following Baton resources:

- Users
- Groups
- Permissions

# Contributing, Support and Issues

We started Baton because we were tired of taking screenshots and manually building spreadsheets. We welcome contributions, and ideas, no matter how small -- our goal is to make identity and permissions sprawl less painful for everyone. If you have questions, problems, or ideas: Please open a Github Issue!

See [CONTRIBUTING.md](https://github.com/ConductorOne/baton/blob/main/CONTRIBUTING.md) for more details.

# `baton-snipe-it` Command Line Usage

```
baton-snipe-it

Usage:
  baton-snipe-it [flags]
  baton-snipe-it [command]

Available Commands:
  capabilities       Get connector capabilities
  completion         Generate the autocompletion script for the specified shell
  help               Help about any command

Flags:
      --access-token string    API key for the snipe-it instance
      --base-url string        Base URL for the snipe-it instance
      --client-id string       The client ID used to authenticate with ConductorOne ($BATON_CLIENT_ID)
      --client-secret string   The client secret used to authenticate with ConductorOne ($BATON_CLIENT_SECRET)
  -f, --file string            The path to the c1z file to sync with ($BATON_FILE) (default "sync.c1z")
  -h, --help                   help for baton-snipe-it
      --log-format string      The output format for logs: json, console ($BATON_LOG_FORMAT) (default "json")
      --log-level string       The log level: debug, info, warn, error ($BATON_LOG_LEVEL) (default "info")
  -p, --provisioning           This must be set in order for provisioning actions to be enabled. ($BATON_PROVISIONING)
  -v, --version                version for baton-snipe-it

Use "baton-snipe-it [command] --help" for more information about a command.
```