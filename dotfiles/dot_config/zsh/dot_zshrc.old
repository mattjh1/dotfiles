# prompt init
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/nordtron.omp.json)"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

path+=('/Users/holmgmat/.local/bin')

killport() { 
sudo kill -9 $(sudo fuser -n tcp $1 2> /dev/null);
}

# fuzzy search through aliases and run selected alias
fa() {
  local alias_name
  local selected_alias

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
    echo -e "Selected alias: $selected_alias\n"
    echo  "Supply args (press enter for no args): "
    read args

    if [ -n "$args" ]; then
      eval "$alias_name $args"
    else
      eval "$alias_name"
    fi
  fi
}

# nnn conf for tmux sess
# n() {
# 	if [ -n "$TMUX" ]; then
# 			nnn -ae $@
# 	else
# 			tmux new-session nnn -ae $@
# 	fi
# }

pathprepend() {
for ARG in "$@"
do
  while [[ $PATH =~ :$ARG: ]]
  do
    PATH=${PATH//:$ARG:/:}
  done
  PATH=${PATH#$ARG:}
  PATH=${PATH%:$ARG}
  export PATH=${ARG}:${PATH}
done
}

export EDITOR="nvim"
export PATH
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export FZF_DEFAULT_COMMAND='ag -l --path-to-ignore ~/.ignore --nocolor --hidden -g ""'
export FZF_DEFAULT_OPTS="--history=$HOME/.fzf_history"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# export PATH="/Users/holmgmat/.local/bin"

export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
alias nvm="unalias nvm;   [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"; nvm $@"

# Then, source plugins and add commands to $PATH
plugins=(git zsh-autosuggestions zsh-interactive-cd macos fzf zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

VI_MODE_SET_CURSOR=true

function cd {
    builtin cd "$@" && ls -laH
}

function awslogs {
  aws --profile beelab --region "$1" logs tail --follow "$2" 
}

# Example aliases
# alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias clr="clear"
alias reload="source ~/.zshrc && source ~/.bash_profile"
alias zshconfig="vim ~/.zshrc"
alias ll="ls -laH"
alias lt='du -sh * | sort -h'
alias ..="cd .."
alias .2="cd ../../"
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias mkdir='mkdir -pv'
alias h="history"
alias path='echo -e ${PATH//:/\\n}'
alias ping='ping -c 5'
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias count='ls -1 | wc -l'
alias s='spotify'
alias sp='spotify next'
alias sn='spotify prev'
alias spp='spotify pause'
alias st='spotify status'
alias zz='pmset displaysleepnow'
alias myip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2'
alias mycomp='system_profiler SPSoftwareDataType SPHardwareDataType'
alias kc="minikube kubectl --"
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias cat="bat --style=plain"

# Journal uses its own vim config
alias journal="nvim -u ~/.config/nvim-backup/journal.vim"

# use this for dotfiles git repo
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# tmux
alias tm="tmux"
alias tma="tmux attach-session"
alias tmat="tmux attach-session -t"
alias tmks="tmux kill-session -a"
alias tml="tmux list-sessions"
alias tmn="tmux new-session"
alias tmns="tmux new -s"
alias tms="tmux new-session -s"

# ensure these programs run with color within tmux ~/.terminfo mess it up, but italics yey!
alias ranger="TERM=screen-256color ranger"
alias n="TERM=screen-256color n"
alias htop="TERM=screen-256color htop"

eval "$(pyenv init -)"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"


# Load Angular CLI autocompletion.
# source <(ng completion script)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/holmgmat/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/holmgmat/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/holmgmat/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/holmgmat/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd() {
    \builtin pwd -L
}

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd() {
    # shellcheck disable=SC2164
    \builtin cd -- "$@"
}

# =============================================================================
#
# Hook configuration for zoxide.
#

# Hook to add new entries to the database.
function __zoxide_hook() {
    # shellcheck disable=SC2312
    \command zoxide add -- "$(__zoxide_pwd)"
}

# Initialize hook.
# shellcheck disable=SC2154
if [[ ${precmd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]] && [[ ${chpwd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]]; then
    chpwd_functions+=(__zoxide_hook)
fi

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

__zoxide_z_prefix='z#'

# Jump to a directory using only keywords.
function __zoxide_z() {
    # shellcheck disable=SC2199
    if [[ "$#" -eq 0 ]]; then
        __zoxide_cd ~
    elif [[ "$#" -eq 1 ]] && { [[ -d "$1" ]] || [[ "$1" = '-' ]] || [[ "$1" =~ ^[-+][0-9]$ ]]; }; then
        __zoxide_cd "$1"
    elif [[ "$@[-1]" == "${__zoxide_z_prefix}"* ]]; then
        # shellcheck disable=SC2124
        \builtin local result="${@[-1]}"
        __zoxide_cd "${result:${#__zoxide_z_prefix}}"
    else
        \builtin local result
        # shellcheck disable=SC2312
        result="$(\command zoxide query --exclude "$(__zoxide_pwd)" -- "$@")" &&
            __zoxide_cd "${result}"
    fi
}

# Jump to a directory using interactive search.
function __zoxide_zi() {
    \builtin local result
    result="$(\command zoxide query -i -- "$@")" && __zoxide_cd "${result}"
}

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

\builtin unalias z &>/dev/null || \builtin true
function z() {
    __zoxide_z "$@"
}

\builtin unalias zi &>/dev/null || \builtin true
function zi() {
    __zoxide_zi "$@"
}

if [[ -o zle ]]; then
    function __zoxide_z_complete() {
        # Only show completions when the cursor is at the end of the line.
        # shellcheck disable=SC2154
        [[ "${#words[@]}" -eq "${CURRENT}" ]] || return 0

        if [[ "${#words[@]}" -eq 2 ]]; then
            _files -/
        elif [[ "${words[-1]}" == '' ]]; then
            \builtin local result
            # shellcheck disable=SC2086,SC2312
            if result="$(\command zoxide query --exclude "$(__zoxide_pwd)" -i -- ${words[2,-1]})"; then
                result="${__zoxide_z_prefix}${result}"
                # shellcheck disable=SC2296
                compadd -Q "${(q-)result}"
            fi
            \builtin printf '\e[5n'
        fi
        return 0
    }

    \builtin bindkey '\e[0n' 'reset-prompt'
    if [[ "${+functions[compdef]}" -ne 0 ]]; then
        \compdef -d z
        \compdef -d zi
        \compdef __zoxide_z_complete z
    fi
fi

# =============================================================================
#
# To initialize zoxide, add this to your configuration (usually ~/.zshrc):
#
 eval "$(zoxide init zsh)"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH:$HOME/go/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source /Users/holmgmat/.pyenv/versions/3.10.8/envs/neovim/bin/activate
