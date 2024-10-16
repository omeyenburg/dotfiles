#!/bin/sh

shopt -s dotglob
BASEDIR=$(dirname "$0")
CONFIGDIR=$(realpath "$BASEDIR")/config

for path in $CONFIGDIR/*; do
    echo "Linking config: $path"
    rm -rf "$HOME/.config/$(basename "$path")"
    ln -sfn $path "$HOME/.config/$(basename "$path")"
done
