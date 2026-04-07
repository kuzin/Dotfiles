# dotfiles

Personal macOS + terminal setup, managed in GitHub-friendly structure.

## Layout
- `zsh/`: shell config modules
- `git/`: global git config and ignore rules
- `macos/`: reviewed OS defaults script (not auto-applied)
- `bootstrap.sh`: installs tools and links configs
- `Brewfile`: Homebrew dependencies

## First-time setup
```bash
./bootstrap.sh
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
5. Optionally sources local, untracked overrides from `~/.dotfiles.local.zsh`

## macOS defaults review workflow
1. Preview staged changes:
```bash
./macos/defaults.sh --review
```
2. Apply only after approval:
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

## Git identity split
- Base config is in `git/.gitconfig`
- Path-specific overrides:
  - `~/.gitconfig-work` (linked from `git/.gitconfig-work`)
  - `~/.gitconfig-personal` (linked from `git/.gitconfig-personal`)
- Work profile auto-applies for selected directories under `~/Code`

## GitHub remote
Suggested remote:
```bash
git remote add origin git@github.com:<your-user>/dotfiles.git
```
