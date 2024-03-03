#!/bin/sh

# Confirm exit with Y/N
function confirm_exit() {
    read -rp "Do you really want to exit? (y/n): " choice
    case "$choice" in
        [Yy])
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Resuming..."
            ;;
    esac
}

# Trap Ctrl-C and call the confirmation function
function ctrl_c() {
    confirm_exit
}

trap ctrl_c SIGINT

no_of_terminals=$(/opt/homebrew/bin/tmux list-sessions | wc -l)
IFS=$'\n'
output=($(/opt/homebrew/bin/tmux list-sessions))
output_names=($(/opt/homebrew/bin/tmux list-sessions -F\#S))
k=1
echo "Choose the terminal to attach: "
for i in "${output[@]}"; do
	echo "$k - $i"
	((k++))
done
echo
echo "Create a new session by entering a name for it"
read -r input
if [[ $input == "" ]]; then
	/opt/homebrew/bin/tmux new-session
elif [[ $input == 'nil' ]]; then
	exit 1
elif [[ $input =~ ^[0-9]+$ ]] && [[ $input -le $no_of_terminals ]]; then
    terminal_name="${output_names[input - 1]}"
	/opt/homebrew/bin/tmux attach -t "$terminal_name"
else
	/opt/homebrew/bin/tmux new-session -s "$input"
fi
ext 0
