# Kickstart.nvim upstream sync

This config is vendored from [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
(branch `master` — no tags/releases upstream, it's a rolling branch meant to be
forked and hand-customized). It was imported as plain files (no submodule/subtree),
so staying in sync is a scripted diff-and-overwrite, not a git merge.

## Local divergence (must survive every sync)

Only `init.lua` has ever diverged from stock, in two spots:

1. The LSP `servers` table: custom `gopls` root_dir, `tsgo` replacing
   `tsserver`/`ts_ls`, `eslint` added with a monorepo-aware root_dir, and an
   adjusted `ensure_installed` mason list.
2. Two trailing lines after `{ import = 'custom.plugins' }`:
   `require 'custom.options'` and `require 'custom.keybinds'`.

Everything else that also exists upstream (`README.md`, `LICENSE.md`, `doc/`,
`dot_gitignore`, `dot_stylua.toml`, `lua/kickstart/**`) is stock and safe to
overwrite wholesale.

Local-only, never touched by sync: `lua/custom/**`, `lua/plugins.old/`
(dead pre-kickstart config, kept for reference), `lazy-lock.json`.

## How to sync

```sh
scripts/nvim-sync-kickstart.sh
```

Run from repo root. It clones upstream to a scratch dir, diffs against the
last-synced SHA (tracked in `.kickstart-upstream-sha` next to this file),
prints a warning if `init.lua` changed upstream, rsyncs every other stock
file, renames any freshly-introduced literal dotfiles to chezmoi's `dot_`
convention, and updates the state file.

If it warns about `init.lua`: hand-reapply the upstream diff it prints
around the two divergence regions above. Then:

```sh
git status                                        # watch for stray dotfiles
git diff -- dotfiles/dot_config/nvim/init.lua      # confirm both regions intact
git add dotfiles/dot_config/nvim
git commit -m "nvim: sync kickstart.nvim upstream to <new-sha>"
```

Smoke test: open nvim, confirm no LSP/plugin errors — it's a config, not
code, so "does it boot clean" is the check (in particular, LSP attaches for
a Go and a TS file, the two customized servers).

## Known pre-existing quirk

`pyright` is still in the `servers` table but already dropped from
`ensure_installed`. Not part of this sync setup — don't accidentally "fix"
it while hand-merging a future `init.lua` diff; treat as a separate decision
if ever addressed.
