#!/bin/bash

# Usage: ./show.sh file1 file2 ...

if ! command -v bat &> /dev/null; then
  echo "⚠️  'bat' not found. Falling back to 'cat -n' (no syntax highlighting)." >&2
  USE_BAT=false
else
  USE_BAT=true
fi

# Detect if output is being piped
if [ -t 1 ]; then
  IS_TTY=true
else
  IS_TTY=false
fi

for file in "$@"; do
  if [[ -f "$file" ]]; then
    echo -e "\n===================="
    echo "📄 $file"
    echo "===================="
    if [ "$USE_BAT" = true ]; then
      if [ "$IS_TTY" = true ]; then
        bat --style=numbers --color=always --paging=never "$file"
      else
        bat --style=plain --color=never --paging=never "$file"
      fi
    else
      cat -n "$file"
    fi
  else
    echo "⚠️  Skipping: $file (not a file)"
  fi
done
