# Dotfiles

Chezmoi-managed workstation setup for a mostly stateless machine.

Goal: install an OS, authenticate to GitHub, run one bootstrap command, and get
the shell/editor/dev-tool baseline back in minutes. Secrets and machine-local
credential material are intentionally not stored in Git.

## Bootstrap

### 1. Minimal OS prerequisites

Arch:

```sh
sudo pacman -Syu --needed git curl openssh sudo
```

Ubuntu/Debian:

```sh
sudo apt-get update
sudo apt-get install -y git curl openssh-client sudo ca-certificates
```

macOS:

```sh
xcode-select --install
```

### 2. GitHub access

For a private repo, set up SSH access first:

```sh
ssh-keygen -t ed25519 -C "ilyas@workstation"
cat ~/.ssh/id_ed25519.pub
```

Add the public key to GitHub, then verify:

```sh
ssh -T git@github.com
```

### 3. Apply dotfiles

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:ilyaselhallaoui/Dotfiles.git
```

For an existing local checkout:

```sh
./setup.sh
```

Run the health check:

```sh
dotfiles-doctor
```

## What This Manages

- Shell: zsh/bash startup files, aliases, completions, Oh My Zsh plugins.
- Editor: Neovim/LazyVim configuration.
- Terminal tools: tmux, starship, mise-managed language runtimes.
- Kubernetes tools: kubectl, kubectx/kubens, k9s config.
- Personal scripts in `~/.local/bin`.
- Credential locations as symlinks, not the credential contents.

## Package Strategy

- Arch uses `pacman` for the full baseline, including Kubernetes tools when
  available from the configured repositories.
- Ubuntu/Debian uses `apt` for the base system tools. Tools that are not
  consistently available in apt, such as `starship` and `mise`, are installed
  user-locally into `~/.local/bin`.
- macOS uses Homebrew if it already exists. Install Homebrew before bootstrap if
  this machine should be managed like a daily driver.
- Language runtimes are managed with `mise`:
  - `node@lts`
  - `python@latest`
  - `go@latest`

## Credentials

This repo manages credential locations, not credential material. The default
targets are home-relative so the repo is not tied to a specific laptop,
username, distro, or WSL path:

- `~/.kube/config` points to `~/.local/share/kube/config`.
- `~/.aws` points to `~/.local/share/cloud/aws`.
- `~/.azure` points to `~/.local/share/cloud/azure`.

After bootstrap, restore credentials through your normal secure channel:

```sh
mkdir -p ~/.local/share/kube ~/.local/share/cloud/aws ~/.local/share/cloud/azure
```

Before committing, run:

```sh
dotfiles-secret-check
```

For a redacted kubeconfig view:

```sh
kubeconfig-redacted
```

## Daily Commands

```sh
chezmoi cd
chezmoi diff
chezmoi apply
chezmoi update
dotfiles-doctor
```

## Devcontainer

Open the repository in VS Code and choose `Reopen in Container`. The container
installs chezmoi, applies this checkout as the dotfiles source, and runs the same
lifecycle scripts used on a normal machine.
