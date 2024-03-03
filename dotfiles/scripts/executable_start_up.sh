#!/bin/sh

# Run this script on a new mac to install pre-requistities for ansible playbook
#
# https://github.com/mattjh1/machine-setup

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" -y

# Permanent add to PATH and this session
echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> $HOME/.zprofile
eval $(/opt/homebrew/bin/brew shellenv)

echo "Installing Pyenv..."
brew install pyenv

echo "Checking Pyenv..."
if ! command -v pyenv &> /dev/null; then
  echo "Error: Pyenv not found. Please install Pyenv before running this script."
  exit 1
fi

# Add Pyenv initialization to shell profile
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init --path)"' >> ~/.zshrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc
source ~/.zshrc

echo "Installing Python 3.10"
pyenv install 3.10

echo "Setting Python 3.10 as global version..."
pyenv global 3.10

echo "Installing Ansible..."
pyenv exec python3 -m pip install ansible --user

echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc

echo "Setup completed successfully."
