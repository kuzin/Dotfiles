# dotfiles

Personal macOS + terminal setup, managed in GitHub-friendly structure.

## Layout

- `zsh/`: shell config modules
- `git/`: global git config and ignore rules
- `asdf/`: language/runtime versions
- `starship/`: prompt configuration
- `npm/`: npm config templates (no secrets)
- `gh/`: GitHub CLI config (+ auth template)
- `ssh/`: SSH config (not private keys)
- `cursor/`: stable Cursor config
- `macos/`: reviewed OS defaults script (not auto-applied)
- `bootstrap.sh`: installs tools and links configs
- `Brewfile`: Homebrew dependencies
- `scripts/`: one-shot setup helpers (e.g. asdf)
- `NEW_MACHINE.md`: checklist for a fresh Mac

## First-time setup

```bash
./bootstrap.sh
```

**New computer / OS reinstall:** follow [NEW_MACHINE.md](NEW_MACHINE.md).

## Common commands

```bash
make bootstrap
make doctor
make macos-review
make macos-apply
make npmrc
make gh-auth
make asdf-setup
```

## What bootstrap does

1. Verifies Homebrew exists
2. Installs CLI tools from `Brewfile`
3. Backs up any existing conflicting files to `~/.dotfiles-backups/<timestamp>/`
4. Symlinks:
  - `zsh/.zshrc` -> `~/.zshrc`
  - `zsh/.zprofile` -> `~/.zprofile`
  - `git/.gitconfig` -> `~/.gitconfig`
  - `git/.gitignore_global` -> `~/.gitignore_global`
  - `asdf/.tool-versions` -> `~/.tool-versions`
  - `starship/starship.toml` -> `~/.config/starship.toml`
  - `gh/config.yml` -> `~/.config/gh/config.yml`
  - `ssh/config` -> `~/.ssh/config`
  - `cursor/argv.json` -> `~/.cursor/argv.json`
5. Optionally sources local, untracked overrides from `~/.dotfiles.local.zsh`

## npm config template

- Copy starter config without secrets:

```bash
make npmrc
```

- Then add your auth token locally (do not commit it).

## Security-sensitive files (manual on each machine)

- `~/.npmrc` token values
- `~/.config/gh/hosts.yml` auth token (run `gh auth login`)
- `~/.ssh/github` private key and other SSH private keys
- `~/.netrc`, `~/.aws/*`, `~/.docker/*` credentials
- local app/session caches under `.cursor`, `.claude`, `.copilot`

## macOS defaults review workflow

1. Preview staged changes:

```bash
./macos/defaults.sh --review
```

1. Apply only after approval:

```bash
./macos/defaults.sh --apply
```

## Post-install check

Open a new shell and run:

```bash
source ~/.zshrc
dotfiles_doctor
```

Or use the repo helper:

```bash
./doctor.sh
```

## Git identity

- Single global identity is managed in `git/.gitconfig`

## GitHub remote

Suggested remote:

```bash
git remote add origin git@github.com:<your-user>/dotfiles.git
```

