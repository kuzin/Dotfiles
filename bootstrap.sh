#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    rm -rf "$dst"
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

  echo
  echo "Bootstrap complete."
  echo "Open a new terminal and run: source ~/.zshrc && dotfiles_doctor"
  echo "Review staged macOS tweaks with: ./macos/defaults.sh --review"
}

main "$@"
