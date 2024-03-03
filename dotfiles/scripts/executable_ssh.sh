#!/bin/sh

if [ -z "$1" ]; then
  echo "Please provide a comment when running the script"
  exit 1
fi

echo "Generating a new SSH key..."

# Generating a new SSH key
# https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key
ssh-keygen -t ed25519 -C $1 -f $HOME/.ssh/id_ed25519

# Adding your SSH key to the ssh-agent
# https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent
eval "$(ssh-agent -s)"

if [ -f $HOME/.ssh/config ]; then
    echo "Host *"
    echo " AddKeysToAgent yes"
    echo " UseKeychain yes"
    echo " IdentityFile ~/.ssh/id_ed25519"
else
    echo "Host *"
    echo " AddKeysToAgent yes"
    echo " UseKeychain yes"
    echo " IdentityFile ~/.ssh/id_ed25519"
fi >> $HOME/.ssh/config

ssh-add -K $HOME/.ssh/id_ed25519

# Copy the SSH public key to the clipboard
pbcopy < "$HOME/.ssh/id_ed25519.pub"

# Provide info to the user
echo "Copied SSH public key to the clipboard"
