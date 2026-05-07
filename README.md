# Dotfiles

Professional, idempotent dotfiles managed by chezmoi.

This repository owns the workstation shell/editor/dev-tool experience. It does
not manage Talos. Kubeconfig and cloud credential paths are managed as symlinks
to local private stores, so credential contents are not committed to Git.

## Bootstrap

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply <github-user-or-repo>
```

For a local checkout:

```sh
./setup.sh
```

## Layout

- `.chezmoidata/packages.yaml`: declarative tool and package list.
- `.chezmoiexternal.toml.tmpl`: small set of external shell plugins.
- `run_onchange_*.tmpl`: lifecycle automation for packages and tool versions.
- `private_dot_config/nvim`: LazyVim configuration.
- `private_dot_config/private_k9s`: K9s configuration.
- `private_dot_config/starship.toml`: Starship prompt.
- `private_dot_kube/symlink_config`: kubeconfig symlink, not kubeconfig content.
- `symlink_dot_aws` and `symlink_dot_azure`: cloud config directory symlinks.
- `dot_local/private_bin/executable_*`: personal toolbox scripts installed to `~/.local/bin`.
- `.devcontainer`: isolated VS Code development environment.

## Credentials

This repo manages credential locations, not credential material:

- `~/.kube/config` points to `/mnt/c/Users/ilyas/.kube/config`.
- `~/.aws` points to `/mnt/c/Users/ilyas/.aws`.
- `~/.azure` points to `/mnt/c/Users/ilyas/.azure`.

Before committing, run:

```sh
dotfiles-secret-check
```

For a redacted kubeconfig view:

```sh
kubeconfig-redacted
```

## Devcontainer

Open the repository in VS Code and choose `Reopen in Container`. The container
installs chezmoi, applies this checkout as the dotfiles source, and runs the same
lifecycle scripts used on a normal machine.

## Daily Commands

```sh
chezmoi diff
chezmoi apply
chezmoi update
dotfiles-doctor
```
