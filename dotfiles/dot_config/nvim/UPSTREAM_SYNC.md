# Kickstart.nvim upstream sync

This config is vendored from [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
(branch `master` — no tags/releases upstream, it's a rolling branch meant to be
forked and hand-customized). It was imported as plain files (no submodule/subtree),
so staying in sync is a scripted diff-and-overwrite, not a git merge.

## Local divergence (must survive every sync)

`init.lua` diverges from stock in three spots (a 2026-07 sync missed the
third one and briefly reverted the colorscheme to stock `tokyonight` —
watch for this specifically on every future sync, don't assume "LSP +
trailing requires" is the complete list without re-diffing):

1. The LSP `servers` table: custom `gopls` root_dir, `tsgo` replacing
   `tsserver`/`ts_ls`, `eslint` added with a monorepo-aware root_dir, and an
   adjusted `ensure_installed` mason list.
2. Two trailing lines after `{ import = 'custom.plugins' }`:
   `require 'custom.options'` and `require 'custom.keybinds'`.
3. Colorscheme plugin block: `shaunsingh/nord.nvim` /
   `vim.cmd.colorscheme 'nord'`, replacing stock's `folke/tokyonight.nvim`
   block entirely (same position in the plugin list, same `priority = 1000`
   shape — just swap the plugin name and `config` body, don't merge).

Everything else that also exists upstream (`README.md`, `LICENSE.md`, `doc/`,
`dot_gitignore`, `dot_stylua.toml`, `lua/kickstart/**`) is stock and safe to
overwrite wholesale.

Local-only, never touched by sync: `lua/custom/**`, `lua/plugins.old/`
(dead pre-kickstart config, kept for reference), `lazy-lock.json`.

## Pinned before the vim.pack migration (deliberate)

As of 2026-07, upstream is mid-migration from `lazy.nvim` to Neovim's native
`vim.pack` plugin manager (started at commit `c4605421e52ae77f04fcf2f56d3bbb7a174e7142`,
"Migrate to vim.pack"). This repo is **deliberately pinned to
`cd7adee3cebd9cc915bbe69db5472b7da479e001`**, the last commit before that
migration, so `lua/custom/plugins/*.lua` (still lazy.nvim spec format) keeps
working without a rewrite.

`vim.pack` itself isn't immature — it shipped in Neovim 0.12 stable
(2026-03-29) and kickstart's own maintainers fully adopted it. The reason to
defer is scope: jumping past this pin requires rewriting all 5
`lua/custom/plugins/*.lua` files into `vim.pack.add()` calls and adapting the
LSP section to the new `do...end`-sectioned `init.lua` structure, as a
deliberate follow-up task, not a side effect of a routine sync.

**Gotcha hit once, worth remembering:** when manually catching up to a
specific pinned commit (not just `master` tip), check out that exact commit
in the scratch clone (`git -C <clone> checkout <sha> -- .`) before rsyncing —
copying from the clone's default checked-out working tree silently pulls
whatever `HEAD` happens to be (i.e. the latest tip), not the pinned commit.
`scripts/nvim-sync-kickstart.sh` always diffs/rsyncs against current
`master` tip, so this only matters for a manual one-off catch-up to an
older pin, like this one.

## Current LSP section merge (as of `cd7adee` sync)

At `cd7adee`, upstream's LSP setup already moved from
`mason-lspconfig`'s handler-based `setup()` to native
`vim.lsp.config(name, server)` / `vim.lsp.enable(name)`, and removed the
manual `blink.cmp` capabilities-merging step (blink.cmp wires capabilities
in automatically now, no user code needed). The three local server entries
(`pyright`, `gopls`, `eslint`) sit as plain entries in the shared `servers`
table, picked up automatically by the stock `for name, server in
pairs(servers) do ... end` loop. `tsgo` is deliberately kept **out** of that
table (it's not mason-managed — installed manually via
`npm install -g @typescript/native-preview`) and registered via its own
direct `vim.lsp.config('tsgo', {...})` / `vim.lsp.enable 'tsgo'` calls after
the loop, replacing the old `require('lspconfig.configs')` +
`require('lspconfig').tsgo.setup{}` pattern (the old per-server `.setup()`
call is what the new native API replaces). `ensure_installed` was kept as
the original explicit list rather than switched to stock's
`vim.tbl_keys(servers)`-derived form, to avoid depending on
mason-tool-installer's server-name-to-package-name mapping table for
`eslint` → `eslint-lsp` without being able to verify that mapping directly.

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
