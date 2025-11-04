#!/bin/sh
set -e

echo "🔍 Checking for local changes..."
chezmoi diff
echo
printf "Do you want to re-add and commit these changes? [y/N] "
read answer

case "$answer" in
  [Yy]* )
    chezmoi re-add
    chezmoi cd
    git add -A
    git commit -m "Sync local edits on $(date '+%Y-%m-%d %H:%M:%S')"
    git push
    echo "✅ Chezmoi synced!"
    ;;
  * )
    echo "❌ Aborted."
    ;;
esac
