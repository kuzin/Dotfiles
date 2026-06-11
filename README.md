# dotfiles

Shell and CLI setup for two Macs — the MacBook and **AISTUDIO** (Mac Studio). Cloned once per machine, bootstrapped with Homebrew, verified with a small health check. Shared config lives here; anything machine-specific lives in untracked local files (see [Two machines & local overrides](#two-machines--local-overrides)).

---

## Quick start

```bash
cd ~/Code/dotfiles   # or wherever you cloned this repo
./bootstrap.sh
```

Open a **new** terminal, then:

```bash
make doctor
make asdf-setup      # installs Ruby + Node per asdf/.tool-versions
```

**Ongoing cleanup & repo hygiene:** [MAINTENANCE.md](MAINTENANCE.md) (safe commands, folder cleanup—**Dropbox excluded**, best practices). **Where to put files:** [FOLDER_CONVENTIONS.md](FOLDER_CONVENTIONS.md).

---

## What you get

| Area | In this repo |
|------|----------------|
| Shell | `zsh/` → `~/.zshrc`, `~/.zprofile`; per-machine `~/.dotfiles.local.zsh` (untracked) |
| Git | `git/.gitconfig`, `git/.gitignore_global`; per-machine `~/.gitconfig.local` (untracked) |
| Runtimes | `asdf/.tool-versions` → `~/.tool-versions` |
| Prompt | `starship/starship.toml` → `~/.config/starship.toml` |
| GitHub CLI | `gh/config.yml`; auth via `gh auth login` (see `gh/hosts.yml.example`) |
| SSH | `ssh/config` → `~/.ssh/config`; per-machine `~/.ssh/config.local`; keys stay local only |
| Cursor | `cursor/argv.json` → `~/.cursor/argv.json` |
| npm | `npm/.npmrc.example` — copy to `~/.npmrc`, add token locally |
| Docs | [MAINTENANCE.md](MAINTENANCE.md) (cleanup & repo upkeep), [FOLDER_CONVENTIONS.md](FOLDER_CONVENTIONS.md) (Desktop/Documents layout) |

---

## `make` targets

| Command | Purpose |
|---------|---------|
| `make bootstrap` | `brew bundle` + symlink managed configs |
| `make doctor` | Check tools + symlinks |
| `make asdf-setup` | Add asdf plugins + `asdf install` (+ Corepack for Yarn) |

---

## Fresh machine

1. `xcode-select --install`
2. Install Homebrew: [brew.sh](https://brew.sh/)
3. `git clone git@github.com:<you>/dotfiles.git ~/Code/dotfiles`
4. `cd ~/Code/dotfiles && ./bootstrap.sh`
5. New terminal: `make doctor`
6. `make asdf-setup` — Ruby + Node per `asdf/.tool-versions`
7. `cp zsh/.dotfiles.local.example.zsh ~/.dotfiles.local.zsh`, then edit for this machine
8. `cp npm/.npmrc.example ~/.npmrc` (add token locally)
9. `gh auth login`
10. Bring [secrets](#secrets-never-commit) from 1Password / the old machine

---

## Two machines & local overrides

This repo is shared by the MacBook and AISTUDIO (`studio-ai.local`, serves Ollama on `:11434`).

**Rule of thumb: anything with a hostname, IP, volume path, or username in it goes in an untracked local file — never in shared config.**

| Local file (untracked) | Hooked from | Holds |
|---|---|---|
| `~/.dotfiles.local.zsh` | sourced by `zsh/.zshrc` | machine env (`OLLAMA_MODELS`, Android SDK), `claude-local` / `claude-pick` / `cl`, extra PATH |
| `~/.gitconfig.local` | `[include]` at end of `git/.gitconfig` (local wins) | per-machine git identity / overrides |
| `~/.ssh/config.local` | `Include` at top of `ssh/config` (local wins) | per-machine hosts |
| `~/.npmrc` | copied from `npm/.npmrc.example` | npm defaults + tokens |
| `~/.config/gh/hosts.yml` | created by `gh auth login` | GitHub auth |

All hooks are no-ops when the local file is absent.

**Claude Code:** bare `claude` always uses the cloud. Local Ollama is opt-in per machine via `cl` / `claude-local` / `claude-pick`, defined in `~/.dotfiles.local.zsh` (template: `zsh/.dotfiles.local.example.zsh`).

---

## Bootstrap behavior

1. Requires **Homebrew** ([brew.sh](https://brew.sh/)).
2. Runs **`brew bundle`** against `Brewfile` (asdf, starship, CLI tools like `fzf`, `bat`, etc.).
3. **Backs up** any existing file that would be replaced into `~/.dotfiles-backups/<timestamp>/`.
4. **Symlinks** repo files into `$HOME` (see table above).

---

## Node, Ruby, and Homebrew

- **asdf** installs the Ruby and Node versions listed in `asdf/.tool-versions`. After bootstrap, run `make asdf-setup` on a new machine.
- In **interactive zsh**, asdf shims are **prepended** to `PATH`, so `node` / `ruby` in the terminal usually come from asdf.
- **Homebrew Node** is still useful: other formulae may depend on it, and some tools expect a system-wide `node`. **Keeping both is normal**—you do not need `brew uninstall node` unless you deliberately want a single stack.

---

## Secrets (never commit)

Bring these to a new Mac outside git (1Password, old machine export, or regenerate):

- `~/.ssh/*` private keys  
- `~/.gnupg/`  
- `~/.npmrc` (tokens)  
- `~/.config/gh/hosts.yml` (use `gh auth login`)  
- `~/.netrc`, `~/.aws/`, Docker credentials if you use them  

Large app state under `~/.cursor/`, `~/.claude/`, `~/.copilot/` is not synced here; reinstall extensions and let apps recreate caches.

---

## Git identity

Edit `git/.gitconfig` in this repo (it is symlinked to `~/.gitconfig`). Per-machine identity or overrides go in `~/.gitconfig.local`.

---

## Clone URL

After forking or creating the repo on GitHub:

```bash
git clone git@github.com:<you>/dotfiles.git ~/Code/dotfiles
```
