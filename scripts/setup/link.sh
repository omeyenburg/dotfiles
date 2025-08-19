#!/usr/bin/env bash

CONFDIR="${DOTFILES}config"
HOMEDIR="${DOTFILES}home"
BINDIR="${DOTFILES}scripts/bin"
NIXOS=$([ -d /nix ] && echo true || echo false)

mkdir -p "$HOME/.config"
for file in "$CONFDIR"/*; do
    [ -e "$file" ] || continue
    name=$(basename "$file")

    if [ "$NIXOS" = true ]; then
        case "$name" in
        *gtk*)
            echo "Skipping $name (written by home manager)"
            continue
            ;;
        esac
    fi

    echo "Linking $name"
    dest="$HOME/.config/$name"

    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        backup="${dest}.backup"
        echo "Backing up existing $name to $name.backup"
        mv "$dest" "$backup"
    else
        rm -rf "$dest"
    fi

    rm -rf "$dest"
    ln -sfn "$file" "$dest"
done

for file in "$HOMEDIR"/.[!.]* "$HOMEDIR"/.??*; do
    [ -e "$file" ] || continue
    name=$(basename "$file")

    if [ "$NIXOS" = true ]; then
        case "$name" in
        *gtk*)
            echo "Skipping $name (written by home manager)"
            continue
            ;;
        esac
    fi

    echo "Linking $name"
    dest="$HOME/$name"

    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        backup="${dest}.backup"
        echo "Backing up existing $name to $name.backup"
        mv "$dest" "$backup"
    else
        rm -rf "$dest"
    fi

    rm -rf "$dest"
    ln -sfn "$file" "$dest"
done

mkdir -p "$HOME/.local/bin"
for file in "$BINDIR"/*; do
    [ -e "$file" ] || continue
    name=$(basename "$file")

    echo "Linking $name"
    dest="$HOME/.local/bin/$name"

    ln -sfn "$file" "$dest"
done
