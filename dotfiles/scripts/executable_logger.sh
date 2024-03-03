#!/bin/zsh

if [ $# -lt 1 ]; then
    identifier="cmd"
else
    identifier=$1
fi

timestamp=$(date +"%Y%m%d_%H%M%S")
log_file="$HOME/logger/${timestamp}__${identifier}.log"

input=$(cat)
echo -e "$input"
echo -e "$input" > "$log_file"

