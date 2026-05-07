#!/bin/sh
set -eu

repo="${1:-}"

if ! command -v chezmoi >/dev/null 2>&1; then
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' EXIT
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$tmp"
  PATH="$tmp:$PATH"
fi

if [ -n "$repo" ]; then
  chezmoi init --apply "$repo"
else
  chezmoi init --apply
fi
