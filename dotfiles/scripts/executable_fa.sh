#!/bin/zsh

# fuzzy alias
# fuzzy search through aliases and run selected alias

alias_name=
selected_alias=

# If no arguments are provided, show all aliases
if [ $# -eq 0 ]; then
  selected_alias=$(alias | fzf)
else
  selected_alias=$(alias | grep $1 | fzf)
fi

# selected alias is run if exists
if [ -n "$selected_alias" ]; then
  alias_name=$(echo "$selected_alias" | awk -F'[ =]' '{print $1}')
  
  # Prompt for arguments
  echo -e "command: $alias_name\n"
  echo "Supply args (press enter for no args): "
  read args

  if [ -n "$args" ]; then
    eval "$alias_name $args"
  else
    eval "$alias_name"
  fi
fi

