#!/bin/sh
set -eu

sudo apt-get update
sudo apt-get install -y ca-certificates curl git sudo zsh

if ! command -v chezmoi >/dev/null 2>&1; then
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' EXIT
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$tmp"
  sudo install -m 0755 "$tmp/chezmoi" /usr/local/bin/chezmoi
fi

chezmoi init --source="$PWD"
chezmoi apply --source="$PWD" --destination="$HOME"
