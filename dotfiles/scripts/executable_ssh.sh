#!/bin/sh

# Help message function
show_help() {
    echo "Usage: $0 <email> <key_name>"
    echo ""
    echo "This script generates a new SSH key, adds it to the ssh-agent,"
    echo "updates the SSH config, and copies the public key to the clipboard."
    echo ""
    echo "Arguments:"
    echo "  email      - Your email or comment for the SSH key (e.g., \"user@example.com\")."
    echo "  key_name   - The name of the SSH key file (e.g., \"id_ed25519\" or custom name)."
    echo ""
    echo "Example:"
    echo "  $0 \"user@example.com\" \"my_key_name\""
    exit 1
}

# Check if both arguments are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Error: Missing arguments."
    show_help
fi

COMMENT=$1
KEY_NAME=$2
SSH_KEY_PATH="$HOME/.ssh/$KEY_NAME"

# Check if SSH key already exists
if [ -f "$SSH_KEY_PATH" ]; then
    echo "Warning: An SSH key already exists at $SSH_KEY_PATH."
    read -p "Do you want to overwrite it? (y/N): " choice
    case "$choice" in 
        y|Y ) echo "Overwriting existing SSH key...";;
        * ) echo "Aborting."; exit 1;;
    esac
fi

# Generate SSH key
echo "Generating a new SSH key with name '$KEY_NAME'..."
ssh-keygen -t ed25519 -C "$COMMENT" -f "$SSH_KEY_PATH"

# Start the SSH agent
echo "Starting ssh-agent..."
eval "$(ssh-agent -s)"

# Ensure SSH config exists
SSH_CONFIG="$HOME/.ssh/config"
if [ ! -f "$SSH_CONFIG" ]; then
    touch "$SSH_CONFIG"
fi

# Append SSH settings (avoid duplicates)
if ! grep -q "IdentityFile $SSH_KEY_PATH" "$SSH_CONFIG"; then
    echo "Updating SSH config..."
    cat <<EOF >> "$SSH_CONFIG"

Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile $SSH_KEY_PATH
EOF
else
    echo "SSH config already contains necessary settings."
fi

# Add the key to ssh-agent
echo "Adding SSH key to ssh-agent..."
ssh-add -K "$SSH_KEY_PATH"

# Copy public key to clipboard using available clipboard tool
if command -v pbcopy >/dev/null 2>&1; then
    pbcopy < "$SSH_KEY_PATH.pub"
    echo "SSH public key copied to clipboard (using pbcopy)."
elif command -v xclip >/dev/null 2>&1; then
    xclip -selection clipboard < "$SSH_KEY_PATH.pub"
    echo "SSH public key copied to clipboard (using xclip)."
elif command -v clip >/dev/null 2>&1; then
    clip < "$SSH_KEY_PATH.pub"
    echo "SSH public key copied to clipboard (using clip)."
else
    echo "No clipboard tool found. Please manually copy the key:"
    cat "$SSH_KEY_PATH.pub"
fi

echo "✅ SSH key setup complete!"
