#!/bin/sh

shopt -s dotglob
BASEDIR=$(dirname "$0")
HOMEDIR=$(realpath "$BASEDIR")/home

for path in $HOMEDIR/*; do
    echo "Linking config: $path"
    rm -rf "$HOME/$(basename "$path")"
    ln -sfn $path "$HOME/$(basename "$path")"
done
