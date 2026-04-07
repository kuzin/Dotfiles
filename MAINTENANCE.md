# Maintenance & cleanup

How to keep **this repo** accurate, your **Mac** tidy, and your **folders** under control—without touching **Dropbox**.

---

## Part 1 — This dotfiles repo

### After you change your setup

1. Edit the right files under `~/Code/dotfiles` (see [README.md](README.md)).
2. Run `**make doctor`** in a new terminal to confirm symlinks and tools.
3. If you installed new **Homebrew** CLI tools you want on every machine, add them to `**Brewfile`**, then run `make bootstrap` (or `brew bundle`) to stay consistent.
4. Commit and push when you are happy with the diff.

### Refreshing Homebrew state (optional)

```bash
brew update
brew upgrade          # when you have time
brew cleanup          # remove old versions and caches
brew autoremove -n    # preview orphaned deps; then brew autoremove if OK
```

### Language / package caches (safe, repeatable)


| Tool      | Command                   | Note                          |
| --------- | ------------------------- | ----------------------------- |
| npm       | `npm cache clean --force` | Re-downloads on next install  |
| Yarn (v1) | `yarn cache clean`        | Same idea                     |
| Homebrew  | `brew cleanup`            | Old bottles and vendor rubies |


### asdf

- See what is installed: `asdf list`
- Remove a version you no longer need: `asdf uninstall <plugin> <version>`  
Only remove versions you are sure nothing still uses.

### Do not commit

Secrets and machine-only files: `~/.npmrc` (tokens), `~/.ssh/*` keys, `~/.config/gh/hosts.yml`, `.netrc`, `.aws`, Docker login data, etc. Use [NEW_MACHINE.md](NEW_MACHINE.md) when migrating.

---

## Part 2 — Cleaning folders on your Mac (manual process)

**Layout & naming (Desktop, Documents, no loose files):** [FOLDER_CONVENTIONS.md](FOLDER_CONVENTIONS.md)

**Rule: do not delete, move, rename, or bulk-modify anything under Dropbox.**

Treat as **off limits** unless you are deliberately working *inside* the Dropbox app or their official UI:

- `~/Dropbox` (often a symlink)
- Paths containing `**Dropbox`** in the name (e.g. `Dropbox (Personal)`)
- `**~/Library/CloudStorage/**` entries that belong to Dropbox (names usually include `Dropbox`)

Everything else—`~/Downloads`, `~/Documents`, `~/Code`, `~/Desktop`, old project folders, etc.—you can review on your own schedule.

### Suggested order (low risk → higher judgment)

1. **Downloads** — installers (`.dmg`, `.pkg`), old zips, duplicate files.
2. **Desktop** — move into `Documents` or `Code` or delete if obsolete.
3. `**~/Code` (or your dev root)** — archive or delete clones you no not need; keep `dotfiles`.
4. **Large media** — `Movies`, old exports; use **Apple menu → System Settings → General → Storage** for hints.
5. `**~/Library/Caches`** — use **Storage** settings or app-specific cleanup; avoid blind `rm -rf` on all of `Library`.

### For each folder you open

- Sort by **size** or **date modified** (Finder **List** view + column **Size**).
- Prefer **move to Trash** over permanent delete until you are sure.
- For git repos: if you might need history, **push branches** or note remotes before deleting the folder.

### Docker (when Docker Desktop is running)

```bash
docker system df
docker system prune     # unused data; read the prompt carefully
# docker system prune -a   # more aggressive; removes unused images
```

---

## Part 3 — Best practices (short)

- **Backups:** Time Machine or another backup before big deletes.
- **Encryption:** FileVault on for laptops.
- **Updates:** macOS security updates regularly.
- **One source of truth:** Prefer defining tools in `**Brewfile`** and shell in this repo over one-off installs you cannot reproduce.
- **PATH:** You use **asdf** for dev Node/Ruby in zsh while **Homebrew Node** may satisfy other formulae—that is intentional; see README.

---

## Quick command cheat sheet

```bash
cd ~/Code/dotfiles
make doctor
make bootstrap          # after Brewfile or bootstrap changes
make asdf-setup         # new machine or new .tool-versions

brew cleanup
npm cache clean --force
```

For a full new machine: [NEW_MACHINE.md](NEW_MACHINE.md).