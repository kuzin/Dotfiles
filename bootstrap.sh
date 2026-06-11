#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_ROOT="${HOME}/.dotfiles-backups"
BACKUP_DIR="${BACKUP_ROOT}/$(date +%Y%m%d-%H%M%S)"

ensure_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    return
  fi
  echo "Homebrew is required but not installed."
  echo "Install from: https://brew.sh/"
  exit 1
}

install_brew_packages() {
  echo "Installing Homebrew packages from Brewfile..."
  brew bundle --file "${ROOT_DIR}/Brewfile"
}

link_file() {
  local src="$1"
  local dst="$2"

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "Already linked $dst -> $src"
    return
  fi

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mkdir -p "$BACKUP_DIR"
    mv "$dst" "${BACKUP_DIR}/$(basename "$dst")"
    echo "Backed up $dst -> ${BACKUP_DIR}/$(basename "$dst")"
  fi

  ln -s "$src" "$dst"
  echo "Linked $dst -> $src"
}

main() {
  ensure_homebrew
  install_brew_packages

  link_file "${ROOT_DIR}/zsh/.zshrc" "${HOME}/.zshrc"
  link_file "${ROOT_DIR}/zsh/.zprofile" "${HOME}/.zprofile"
  link_file "${ROOT_DIR}/git/.gitconfig" "${HOME}/.gitconfig"
  link_file "${ROOT_DIR}/git/.gitignore_global" "${HOME}/.gitignore_global"
  link_file "${ROOT_DIR}/asdf/.tool-versions" "${HOME}/.tool-versions"
  mkdir -p "${HOME}/.config"
  link_file "${ROOT_DIR}/starship/starship.toml" "${HOME}/.config/starship.toml"
  mkdir -p "${HOME}/.config/gh"
  link_file "${ROOT_DIR}/gh/config.yml" "${HOME}/.config/gh/config.yml"
  mkdir -p "${HOME}/.ssh"
  link_file "${ROOT_DIR}/ssh/config" "${HOME}/.ssh/config"
  chmod 600 "${HOME}/.ssh/config"
  mkdir -p "${HOME}/.config/ghostty"
  link_file "${ROOT_DIR}/ghostty/config" "${HOME}/.config/ghostty/config"
  mkdir -p "${HOME}/Library/Application Support/Code/User"
  link_file "${ROOT_DIR}/vscode/settings.json" "${HOME}/Library/Application Support/Code/User/settings.json"

  echo
  echo "Bootstrap complete."
  if [ -d "$BACKUP_DIR" ]; then
    echo "Backup created at: $BACKUP_DIR"
  fi
  echo "Open a new terminal and run: source ~/.zshrc && dotfiles_doctor"
  echo
  echo "Optional one-time setup:"
  echo "  Runtimes:     make asdf-setup   # Ruby + Node per ~/.tool-versions, Corepack for Yarn"
  echo "  npm:          cp ${ROOT_DIR}/npm/.npmrc.example ${HOME}/.npmrc"
  echo "  GitHub CLI:   gh auth login"
  echo "  Local config: cp ${ROOT_DIR}/zsh/.dotfiles.local.example.zsh ${HOME}/.dotfiles.local.zsh"
}

main "$@"
