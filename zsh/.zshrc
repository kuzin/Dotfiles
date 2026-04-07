# Base path (auto-detect from this symlinked file)
if [ -n "${ZDOTDIR:-}" ] && [ -f "${ZDOTDIR}/.zshrc" ]; then
  export DOTFILES_DIR="$(cd "$(dirname "$(readlink "${ZDOTDIR}/.zshrc")")/.." && pwd)"
elif [ -f "${HOME}/.zshrc" ] && [ -L "${HOME}/.zshrc" ]; then
  export DOTFILES_DIR="$(cd "$(dirname "$(readlink "${HOME}/.zshrc")")/.." && pwd)"
else
  export DOTFILES_DIR="$HOME/Code/dotfiles"
fi

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

# Completion
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# Homebrew shell env (Apple Silicon + Intel fallback)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Tool integrations
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

[ -f "${HOME}/.fzf.zsh" ] && source "${HOME}/.fzf.zsh"

# Aliases / functions
[ -f "${DOTFILES_DIR}/zsh/aliases.zsh" ] && source "${DOTFILES_DIR}/zsh/aliases.zsh"
[ -f "${DOTFILES_DIR}/zsh/functions.zsh" ] && source "${DOTFILES_DIR}/zsh/functions.zsh"

# Local machine overrides (untracked)
[ -f "${HOME}/.dotfiles.local.zsh" ] && source "${HOME}/.dotfiles.local.zsh"
