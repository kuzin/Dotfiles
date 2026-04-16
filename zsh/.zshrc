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
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache on

# Homebrew shell env (Apple Silicon + Intel fallback)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Remove stale PATH entries left by old Node/Yarn installs.
if [ ! -d "${HOME}/.config/yarn/global/node_modules/.bin" ]; then
  path=(${path:#${HOME}/.config/yarn/global/node_modules/.bin})
fi
# Drop nvm bins so asdf/Homebrew node wins. Reinstall CLI tools (e.g. yarn) under asdf:
#   corepack enable && asdf reshim nodejs   # or: npm i -g yarn && asdf reshim nodejs
path=(${path:#${HOME}/.nvm/versions/node/*/bin})
export PATH

# Prefer asdf shims (matches ~/.tool-versions) over a second Homebrew node install.
if [ -d "${HOME}/.asdf/shims" ]; then
  export PATH="${HOME}/.asdf/shims:${PATH}"
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

# History search with arrow keys
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

if [ "${TERM:-}" != "dumb" ] && command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
