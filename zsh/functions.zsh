dotfiles_doctor() {
  local missing=0
  local bins=(brew git fzf zoxide bat eza rg fd delta)

  echo "Checking required tools..."
  for b in "${bins[@]}"; do
    if command -v "$b" >/dev/null 2>&1; then
      echo "  [ok] $b"
    else
      echo "  [missing] $b"
      missing=1
    fi
  done

  echo
  echo "Checking symlinks..."
  local links=(
    "$HOME/.zshrc"
    "$HOME/.zprofile"
    "$HOME/.gitconfig"
    "$HOME/.gitignore_global"
    "$HOME/.tool-versions"
    "$HOME/.config/starship.toml"
    "$HOME/.config/gh/config.yml"
    "$HOME/.ssh/config"
    "$HOME/.cursor/argv.json"
  )
  for l in "${links[@]}"; do
    if [ -L "$l" ]; then
      echo "  [ok] $l -> $(readlink "$l")"
    else
      echo "  [missing link] $l"
      missing=1
    fi
  done

  if [ "$missing" -eq 0 ]; then
    echo
    echo "dotfiles_doctor: healthy"
  else
    echo
    echo "dotfiles_doctor: issues detected"
    return 1
  fi
}
