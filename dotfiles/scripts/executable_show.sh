#!/bin/bash

# Usage:
#   show file1 file2 ...
#   show --ignore "*.md" --ignore "*.log" file1 file2

IGNORE_PATTERNS=()

# --- Parse args ---
FILES=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    --ignore)
      IGNORE_PATTERNS+=("$2")
      shift 2
      ;;
    *)
      FILES+=("$1")
      shift
      ;;
  esac
done

# --- Check tools ---
if ! command -v bat &> /dev/null; then
  echo "⚠️  'bat' not found. Falling back to 'cat -n'." >&2
  USE_BAT=false
else
  USE_BAT=true
fi

# --- Detect TTY ---
if [ -t 1 ]; then
  IS_TTY=true
else
  IS_TTY=false
fi

# --- Check if inside git repo ---
if git rev-parse --is-inside-work-tree &>/dev/null; then
  IN_GIT=true
else
  IN_GIT=false
fi

# --- Function: match ignore patterns ---
matches_ignore() {
  local file="$1"
  for pattern in "${IGNORE_PATTERNS[@]}"; do
    if [[ "$file" == $pattern ]]; then
      return 0
    fi
  done
  return 1
}

# --- Main loop ---
for file in "${FILES[@]}"; do
  if [[ -f "$file" ]]; then

    # Git ignore check
    if [ "$IN_GIT" = true ] && git check-ignore -q "$file" 2>/dev/null; then
      echo "🙈 Ignored (git): $file"
      continue
    fi

    # Custom ignore check
    if matches_ignore "$file"; then
      echo "🙈 Ignored (pattern): $file"
      continue
    fi

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
