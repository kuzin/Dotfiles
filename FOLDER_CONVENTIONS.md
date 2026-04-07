# Folder layout & naming

Conventions for **Desktop**, **Documents**, and similar “top” locations so things stay easy to search, script, and move to a new Mac.

---

## Capitalization (consistent on this Mac)

Use **Title Case** for folder names under **Documents** (and other places you manage by hand), so they match familiar macOS style (`Adobe`, `Archives`, `Zoom`, etc.).

| Pattern | Examples |
|---------|----------|
| Single word | `Charts`, `Inbox`, `Archives` |
| Several words | Separate with **hyphens**, capitalize each word: `Desktop-Cleanup-2026-04-07`, `Kiosk-Footage-2025` |
| ISO date at end | Keep digits as-is: `…-2026-04-07` |

**Legacy folders** with spaces (`Kiosk Videos V2`, `Holiday Party 2025`) can stay until you rename them on purpose (watch for apps that store full paths).

---

## Core rule: no loose files at the top level

**Top level** means the first screen you see when you open a location:

| Location | Should contain |
|----------|------------------|
| **Desktop** | Nothing except what macOS adds (e.g. `.localized`). Put real work under **folders** or in **Documents**. |
| **Documents** | **Folders only** (plus `.localized` / `.DS_Store`). Individual PDFs, screenshots, exports, and downloads belong inside a folder. |
| **Project / repo root** | Prefer **directories** (`src/`, `docs/`). Avoid one-off files next to `README` unless they are standard (e.g. `LICENSE`). |

**Exception:** Short-lived drops are OK in **`~/Documents/Inbox/`**—then sort them into proper folders when you have a minute.

---

## Where to put things (on this Mac)

| Purpose | Folder |
|---------|--------|
| Random drops, “deal with later” | `~/Documents/Inbox/` |
| Keynote charts / slide decks | `~/Documents/Charts/` |
| Desktop dumps / old Desktop contents | `~/Documents/Archives/Desktop-Cleanup-YYYY-MM-DD/` |

**Dropbox:** Do not use these rules as an excuse to bulk-delete inside Dropbox. See [MAINTENANCE.md](MAINTENANCE.md).

---

## Naming new folders (summary)

1. **Title Case**, words separated by **hyphens** when you create new folders yourself.
2. **Avoid spaces** in **new** names when you can (fewer quoting issues in Terminal).
3. **Optional sort prefix** for ordering: `01-Inbox`, `02-Active`, `99-Archive`
4. **Dates in archive names**: `Desktop-Cleanup-2026-04-07` — description in Title Case, **ISO date** at the end for sorting.
5. **Be specific**: e.g. `Kiosk-Footage-2025` instead of a vague `Videos`.

---

## Quick hygiene

- When you save something to **Desktop**, move it within a day into **`~/Documents/Inbox/`** or another proper folder.
- Once a week (or before backup): empty **`Inbox`** into real folders or delete.
- **Desktop** stays visually empty = less distraction.

---

## Related

- [MAINTENANCE.md](MAINTENANCE.md) — cleanup commands, Dropbox rule, repo upkeep  
- [README.md](README.md) — dotfiles bootstrap
