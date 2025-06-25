#!/bin/bash

# Usage: ./show.sh file1 file2 ...

if ! command -v bat &> /dev/null; then
  echo "⚠️  'bat' not found. Falling back to 'cat -n' (no syntax highlighting)." >&2
  USE_BAT=false
else
  USE_BAT=true
fi

for file in "$@"; do
  if [[ -f "$file" ]]; then
    echo -e "\n===================="
    echo "📄 $file"
    echo "===================="
    if [ "$USE_BAT" = true ]; then
      bat --style=numbers --color=always --paging=never "$file"
    else
      cat -n "$file"
    fi
  else
    echo "⚠️  Skipping: $file (not a file)"
  fi
done
