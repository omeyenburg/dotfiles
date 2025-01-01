#!/bin/sh

# Insert
. ./scripts/append.sh
append "$HOME/.bashrc" 'source "$HOME/.config/shell/session.sh"'
append "$HOME/.bash_profile" 'source "$HOME/.config/shell/profile.sh"'

# Enable starship prompt for bash
eval "$(starship init bash)"
