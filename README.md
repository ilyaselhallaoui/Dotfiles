# Terminal Power User Dotfiles

Chezmoi-managed WSL setup for a mostly stateless, command-line centered
Windows workstation.

Goal: install an OS, authenticate to GitHub, run one bootstrap command, and get
the shell/editor/dev-tool baseline back in minutes. The daily workflow is built
around zsh, tmux, Neovim, SSH, fzf, Fabric, dev containers, and the Windows
host where it makes sense. Native Arch/Sway is optional lab work, not the main
path. Secrets and machine-local credential material are
intentionally not stored in Git.

## Bootstrap

### 1. Minimal OS prerequisites

WSL Ubuntu/Debian:

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
- Terminal tools: tmux, fzf, fd/fdfind, rg, bat, w3m, pass, gh, starship,
  mise-managed runtimes.
- Zettelkasten CLI workflow: `vcd`, `vf`, `fd`, `rg`, `fzf`, `bat`, and Neovim
  for fast Markdown navigation and editing.
- AI CLI workflow: Fabric install path, helper functions, and custom patterns.
- Kubernetes tools: kubectl, kubectx/kubens, k9s config.
- Optional archived Linux desktop draft: Sway, Waybar, Wofi, Foot/Alacritty
  config. This is not part of the WSL daily-driver path.
- Personal scripts in `~/.local/bin`.
- Credential locations as symlinks, not the credential contents.

## Package Strategy

- WSL Ubuntu/Debian uses `apt` for the base system tools. Tools that are not
  consistently available in apt, such as `starship` and `mise`, are installed
  user-locally into `~/.local/bin`.
- Homebrew on Linux is not managed by default. This avoids WSL bootstrap runs
  unexpectedly installing or updating Brew packages.
- macOS uses Homebrew if it already exists.
- Language runtimes are managed with `mise`:
  - `node@lts`
  - `python@latest`
  - `go@latest`

## Workflow Layers

1. Shell basics: bash/zsh, man pages, history, find, grep/rg, pipes, redirects.
2. Navigation and search: fzf, fd/fdfind, rg, tree.
3. Terminal workbench: tmux with mostly default keybindings.
4. Editor: Neovim/LazyVim.
5. Remote systems: SSH, port forwarding, rsync.
6. Passwords and keys: pass/GPG. Secrets are not committed.
7. AI on the command line: Fabric, custom patterns, YouTube transcripts.
8. Isolated development: dev containers and project-local toolchains.
9. Optional native Linux desktop lab: Arch + Sway only if WSL no longer fits a
   concrete need.

## Fabric Helpers

After `fabric --setup`, these shell helpers become useful:

```sh
ask "question"
fsum < file.md
wisdom < transcript.txt
claims < article.txt
explain < script.sh
tags < note.md
yt "https://youtube.com/watch?v=..."
ytw "https://youtube.com/watch?v=..."
```

Custom patterns live in:

```text
~/.config/fabric/custom-patterns
```

Current custom patterns:

- `routine_review`
- `devops_study_notes`
- `careerlaunch_content`
- `telos_reflect`

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
