# Shared environment for zsh and bash. Managed by chezmoi.

export EDITOR=nvim VISUAL=nvim PAGER=less
export GOPATH="$HOME/go"
export BUN_INSTALL="$HOME/.bun"
export FABRIC_CUSTOM_PATTERNS_DIR="$HOME/.config/fabric/custom-patterns"
export PATH="$HOME/.local/bin:$BUN_INSTALL/bin:$GOPATH/bin:$PATH"

if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
