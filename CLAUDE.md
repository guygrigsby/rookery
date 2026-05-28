# Project Instructions for AI Agents

This app was generated from the `rookery` template. It is a two-binary
daemon/CLI built on `github.com/guygrigsby/perch`.

## Build & Test

```bash
make build    # SPA + appd + appctl
make test     # go test + vitest + init smoke
make check    # one-shot gate: gofmt, vet, golangci-lint, test, web build
make dev      # appd watcher + Vite, both hot-reload
```

**Run `make check` before claiming any task is done.** It is the same gate CI runs.

## Architecture

- `cmd/appd` — daemon. Wires `perch/config` + `internal/api` + `perch/daemon.Serve`.
- `cmd/appctl` — CLI client over `perch/client` (`auth login`, `auth logout`, `whoami`).
- `internal/api` — HTTP routes: `/healthz`, loopback `/api/auth/mint`, auth-gated `/api/whoami`, static SPA.
- `internal/auth` — loopback token mint + SHA-256 hash validate. Customize per app.
- `embed.go` — embeds `web/dist` (the optional Svelte SPA).

## Conventions

- Config: `~/.config/app/config.toml`. Token: `~/.config/app/cli.token` (0600).
- Logs: `~/.logs/app/`. Default listen `:8080`.

## Issue Tracking (bd / beads)

Use `bd` for ALL task tracking — do NOT use TodoWrite or markdown TODO lists.

```bash
bd ready             # available work
bd create --title="..." --type=task --priority=2
bd update <id> --claim
bd close <id>
```

## Session Completion

Work is NOT complete until pushed:
1. `make check` passes
2. commit
3. `git push` (and `bd dolt push` if using beads remote)
4. `git status` shows up to date
