#!/bin/sh

[[ -n $1 ]] && cd "$1" # go to provided folder or noop

export FZF_DEFAULT_COMMAND="rg --files"

selected=$(
fzf \
--ansi \
--preview-window 'right,50%,border-bottom' \
--preview 'bat -f {1}'
)

[[ -n $selected ]] && code "$selected"
