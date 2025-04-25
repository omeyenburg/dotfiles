#!/bin/sh

# Insert
. ./scripts/utils/append.sh
append "$HOME"/.bashrc 'source "$HOME/.config/shell/session.sh"'
append "$HOME"/.bash_profile 'source "$HOME/.config/shell/profile.sh"'
