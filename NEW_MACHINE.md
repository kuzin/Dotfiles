# New Mac checklist

Use this after a clean macOS install (or new machine). Goal: **clone dotfiles → bootstrap → auth → install languages**.

## 1. System prerequisites

1. Install **Xcode Command Line Tools**: `xcode-select --install`
2. Install **Homebrew**: https://brew.sh/
3. Clone this repo, e.g. `git clone … ~/Code/dotfiles`

## 2. Apply dotfiles

```bash
cd ~/Code/dotfiles
./bootstrap.sh
# or: make bootstrap
```

Open a **new** terminal, then:

```bash
make doctor
```

## 3. Secrets (never in git — bring over manually)

Copy or recreate on the new Mac:

| Item | How |
|------|-----|
| SSH private keys | `~/.ssh/` (e.g. `github`) + keep `ssh/config` from repo |
| GPG keys | `~/.gnupg/` (export/import securely) |
| `gh` login | `gh auth login` or `make gh-auth` |
| npm token | merge into `~/.npmrc` (use `npm/.npmrc.example` as base) |
| `.netrc`, `.aws/`, Docker creds | copy only if you still use those tools |

## 4. asdf (Ruby + Node from `.tool-versions`)

After `bootstrap.sh` installed Homebrew packages:

```bash
./scripts/asdf-setup.sh
```

If Node plugin complains about keys, install macOS deps first:

```bash
brew install gpg
```

Then re-run `./scripts/asdf-setup.sh`.

## 5. Optional: one Node stack only

You use **asdf** for Node (see `asdf/.tool-versions`). To avoid two `node` installs:

```bash
brew uninstall node   # optional; keeps PATH simpler
```

## 6. Editors / AI apps

- **Cursor / VS Code**: reinstall extensions (not stored in this repo).
- **`.cursor/`**, **`.claude/`**, **`.copilot/`**: local state/cache — do not sync wholesale; let apps recreate.

## 7. macOS preferences

Review (no obligation to apply):

```bash
make macos-review
# ./macos/defaults.sh --apply   # only if you want them
```
