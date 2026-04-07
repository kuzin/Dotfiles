# dotfiles

macOS shell and CLI setup meant to be **cloned once on a new machine**, bootstrapped with Homebrew, then verified with a small health check.

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

**Fresh Mac or OS reinstall:** use the full checklist in [NEW_MACHINE.md](NEW_MACHINE.md) (Xcode CLT, Homebrew, secrets, `gh auth`, etc.).

---

## What you get

| Area | In this repo |
|------|----------------|
| Shell | `zsh/` → `~/.zshrc`, `~/.zprofile`; optional `~/.dotfiles.local.zsh` (untracked) |
| Git | `git/.gitconfig`, `git/.gitignore_global` |
| Runtimes | `asdf/.tool-versions` → `~/.tool-versions` |
| Prompt | `starship/starship.toml` → `~/.config/starship.toml` |
| GitHub CLI | `gh/config.yml`; auth via `gh auth login` (see `gh/hosts.yml.example`) |
| SSH | `ssh/config` → `~/.ssh/config` (keys stay local only) |
| Cursor | `cursor/argv.json` → `~/.cursor/argv.json` |
| npm | `npm/.npmrc.example` — copy to `~/.npmrc`, add token locally |
| macOS | `macos/defaults.sh` — review with `--review`, apply with `--apply` only if you want |

Other paths in `bootstrap.sh`, `Makefile`, and `scripts/` tie it together.

---

## `make` targets

| Command | Purpose |
|---------|---------|
| `make bootstrap` | `brew bundle` + symlink managed configs |
| `make doctor` | Check tools + symlinks |
| `make asdf-setup` | Add asdf plugins + `asdf install` |
| `make npmrc` | Copy `npm/.npmrc.example` → `~/.npmrc` |
| `make gh-auth` | `gh auth login` |
| `make macos-review` | Print planned defaults (no changes) |
| `make macos-apply` | Apply `macos/defaults.sh` |

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

## macOS defaults

Keyboard, Finder, and Dock tweaks live in `macos/defaults.sh`. **Screenshots are not changed.**

```bash
make macos-review    # describe what --apply would do
make macos-apply       # only when you explicitly want them
```

---

## Git identity

Edit `git/.gitconfig` in this repo (it is symlinked to `~/.gitconfig`).

---

## Clone URL

After forking or creating the repo on GitHub:

```bash
git clone git@github.com:<you>/dotfiles.git ~/Code/dotfiles
```
