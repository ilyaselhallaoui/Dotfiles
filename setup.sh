#!/bin/sh
set -eu

repo="${1:-git@github.com:ilyaselhallaoui/Dotfiles.git}"

if ! command -v chezmoi >/dev/null 2>&1; then
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' EXIT
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$tmp"
  PATH="$tmp:$PATH"
fi

if chezmoi source-path >/dev/null 2>&1 && [ -d "$(chezmoi source-path)" ]; then
  chezmoi apply
else
  chezmoi init --apply "$repo"
fi
