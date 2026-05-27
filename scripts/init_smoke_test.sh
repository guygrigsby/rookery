#!/usr/bin/env bash
# Smoke test: a fresh checkout, renamed via init.sh, must build and vet — both
# with web and headless. Runs in temp dirs; never mutates this repo.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

run_case() {
  local label="$1"; shift
  local tmp; tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' RETURN
  git -C "$ROOT" archive --format=tar HEAD | (cd "$tmp" && tar xf -)
  ( cd "$tmp" && git init -q && git add -A && \
      git -c user.email=t@t -c user.name=t commit -qm init && \
      bash scripts/init.sh demoapp "$@" && \
      go mod tidy >/dev/null 2>&1 && \
      go build ./... && go vet ./... )
  echo "✓ init smoke: $label"
}

run_case "with web"
run_case "headless" --no-web
echo "✓ init.sh smoke test passed"
