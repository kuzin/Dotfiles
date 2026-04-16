#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v asdf >/dev/null 2>&1; then
  echo "asdf not found. Run ./bootstrap.sh first (installs asdf via Homebrew)."
  exit 1
fi

asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git 2>/dev/null || true
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git 2>/dev/null || true

if ! asdf plugin list | grep -qx nodejs; then
  echo "Failed to add nodejs plugin."
  exit 1
fi

# Versions are defined in ~/.tool-versions (symlinked by bootstrap).
cd "$HOME"
asdf install

# Node ships Corepack (Yarn, pnpm). Enable once per install so shims exist after NVM→asdf.
NODE_ROOT="$(cd "$HOME" && asdf where nodejs 2>/dev/null || true)"
if [ -n "${NODE_ROOT}" ] && [ -x "${NODE_ROOT}/bin/corepack" ]; then
  "${NODE_ROOT}/bin/corepack" enable
  asdf reshim nodejs
fi

echo "asdf install complete. Open a new shell and run: node -v && ruby -v && command -v yarn"
