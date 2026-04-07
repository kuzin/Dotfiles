#!/usr/bin/env bash
set -euo pipefail

show_review() {
  cat <<'EOF'
Staged macOS defaults (review-first):

Keyboard:
- Fast key repeat
- Short key repeat delay

Finder:
- Show all filename extensions
- Show path bar
- Keep folders first when sorting by name

Dock:
- Auto-hide Dock
- Reduce auto-hide delay

Screenshots:
- Save to ~/Screenshots
- Use PNG format

Nothing is applied in --review mode.
EOF
}

apply_defaults() {
  mkdir -p "${HOME}/Screenshots"

  # Keyboard
  defaults write NSGlobalDomain KeyRepeat -int 2
  defaults write NSGlobalDomain InitialKeyRepeat -int 15

  # Finder
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
  defaults write com.apple.finder ShowPathbar -bool true
  defaults write com.apple.finder _FXSortFoldersFirst -bool true

  # Dock
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock autohide-delay -float 0

  # Screenshots
  defaults write com.apple.screencapture location -string "${HOME}/Screenshots"
  defaults write com.apple.screencapture type -string "png"

  killall Finder >/dev/null 2>&1 || true
  killall Dock >/dev/null 2>&1 || true
  killall SystemUIServer >/dev/null 2>&1 || true

  echo "macOS defaults applied."
}

main() {
  local mode="${1:---review}"
  case "$mode" in
    --review)
      show_review
      ;;
    --apply)
      apply_defaults
      ;;
    *)
      echo "Usage: $0 [--review|--apply]"
      exit 1
      ;;
  esac
}

main "$@"
