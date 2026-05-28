# app

Generated from [rookery](https://github.com/guygrigsby/rookery): a two-binary
daemon/CLI app on [perch](https://github.com/guygrigsby/perch).

- `appd` — the daemon (serves the API + embedded SPA).
- `appctl` — the CLI client (`auth login`, `whoami`).

## Quick start

```bash
make build
./appd &                 # starts on :8080
./appctl auth login      # mint + store a token
./appctl whoami          # authenticated call
```

## Make targets

`make help` lists everything. The important ones: `build`, `test`, `check`
(the quality gate), `dev` (hot-reload loop), and the launchd set
(`install-launchd`, `redeploy`, `service-restart`).

## New app from this template

```bash
scripts/init.sh <name> [--no-web]
```
Renames the binaries, module path, launchd label, and config/log dirs, and
re-initializes the bd tracker. `--no-web` drops the Svelte layer for a headless
service.
