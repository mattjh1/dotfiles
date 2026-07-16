#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
NVIM_DIR="$REPO_ROOT/dotfiles/dot_config/nvim"
STATE_FILE="$NVIM_DIR/.kickstart-upstream-sha"
UPSTREAM_URL="https://github.com/nvim-lua/kickstart.nvim"
SCRATCH="/tmp/kickstart-upstream"

last_sha=$(cat "$STATE_FILE")

rm -rf "$SCRATCH"
git clone --quiet "$UPSTREAM_URL" "$SCRATCH"
new_sha=$(git -C "$SCRATCH" rev-parse master)

if [ "$last_sha" = "$new_sha" ]; then
  echo "Already up to date ($new_sha)."
  rm -rf "$SCRATCH"
  exit 0
fi

echo "Upstream changed: $last_sha -> $new_sha"
git -C "$SCRATCH" diff "$last_sha".."$new_sha" --stat

if git -C "$SCRATCH" diff "$last_sha".."$new_sha" --name-only | grep -qx 'init.lua'; then
  echo
  echo "!!! init.lua changed upstream — hand-reapply local edits after this script runs:"
  echo "    git -C $SCRATCH diff $last_sha..$new_sha -- init.lua"
  echo "    (LSP servers table + trailing custom.options/custom.keybinds requires)"
fi

rsync -a --exclude='.git' --exclude='init.lua' \
  --exclude='lua/custom/' --exclude='lua/plugins.old/' --exclude='lazy-lock.json' \
  "$SCRATCH"/ "$NVIM_DIR"/

# chezmoi needs dot_-prefixed names; upstream ships literal dotfiles
[ -f "$NVIM_DIR/.gitignore" ]   && mv "$NVIM_DIR/.gitignore"   "$NVIM_DIR/dot_gitignore"
[ -f "$NVIM_DIR/.stylua.toml" ] && mv "$NVIM_DIR/.stylua.toml" "$NVIM_DIR/dot_stylua.toml"
extra_dot=$(find "$NVIM_DIR" -maxdepth 2 -name '.*' -not -name '.git*' -not -name '.kickstart-upstream-sha')
[ -n "$extra_dot" ] && echo "!!! New unhandled dotfiles introduced, rename manually: $extra_dot"

echo "$new_sha" > "$STATE_FILE"
rm -rf "$SCRATCH"

echo
echo "Synced to $new_sha. Review 'git status' and 'git diff -- $NVIM_DIR/init.lua', then commit."
