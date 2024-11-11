#!/bin/sh

# Adjust dracula bar colors
temp_file="$(mktemp)"
sed_script="$HOME/.config/tmux/dracula.sed"
dracula_script="$HOME/.tmux/plugins/tmux/scripts/dracula.sh"

sed -f $sed_script $dracula_script > $temp_file
cat $temp_file > $dracula_script
