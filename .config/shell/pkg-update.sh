#!/bin/bash

# This script runs with root privileges; commands with user_cmd without
user_cmd() {
    sudo -u "$SUDO_USER" "$@"
}

# Check if command is installed
is_installed() {
    command -v "$1" >/dev/null 2>&1
}

# Update apt packages (skip confirm)
if is_installed apt; then
    echo "Updating apt packages..."
    apt update && apt upgrade -y
fi

# Update Snap packages
if is_installed snap; then
    echo "Updating Snap packages..."
    snap refresh
fi

# Update Homebrew packages
if is_installed brew; then
    echo "Updating Homebrew packages..."
    user_cmd brew update
    user_cmd brew upgrade
    user_cmd brew cleanup
fi

# Update MacPorts packages
if is_installed port; then
    echo "Updating MacPorts packages..."
    user_cmd port selfupdate
    user_cmd port upgrade outdated
fi

echo "Update process completed!"
