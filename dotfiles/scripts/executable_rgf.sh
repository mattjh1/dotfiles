#!/bin/sh
##
# Interactive search.
#

trap 'exit' INT

[[ -n $1 ]] && cd "$1" # go to provided folder or noop

export FZF_DEFAULT_COMMAND="rg --column --line-number --no-heading --color=always -- ''"
selected=$(
  fzf \
    --ansi \
    --delimiter : \
    --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
    --preview 'bat -f --highlight-line={2} {1}' | cut -d":" -f1,2,3
)

[[ -n $selected ]] && code -g "$PWD"/"$selected"
