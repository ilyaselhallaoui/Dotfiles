# Dotfiles

Managed with [chezmoi](https://chezmoi.io). This repo is the **only** place dotfiles live:

- source: `~/.local/share/chezmoi` (this repo, `github.com/ilyaselhallaoui/Dotfiles`)
- target: `~` — files here get applied to your home dir

## Daily use

```sh
chezmoi edit ~/.zshrc     # edit the source, not the live file
chezmoi diff              # preview
chezmoi apply             # write to ~
chezmoi cd                # jump into the repo to commit/push
```

New machine: `sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply ilyaselhallaoui/Dotfiles`

## Layout

| Source | Becomes |
|---|---|
| `dot_zshrc`, `dot_bashrc` | thin shell rc files |
| `private_dot_config/shell/env.sh` | PATH + env, shared by both shells |
| `private_dot_config/shell/aliases.sh.tmpl` | aliases + functions, shared by both shells |
| `private_dot_ssh/private_config` | `~/.ssh/config` (`ssh homelab`) |
| `private_dot_config/{nvim,starship.toml,k9s,fabric}` | app configs |
| `private_dot_config/{sway,waybar,foot,wofi}` | Arch desktop only (skipped on WSL) |
| `dot_local/private_bin/` | small helper scripts |
| `.chezmoidata/packages.yaml` | apt / brew / mise package lists |
| `run_once_before_00-setup.sh.tmpl` | one-time: zsh + oh-my-zsh |
| `run_onchange_10-install.sh.tmpl` | installs packages when the list changes |

Node/Python/Go are managed by **mise** only.
Credentials (`~/.aws`, `~/.azure`, `~/.kube/config`) are symlinks into `~/.local/share/` and never committed.
