#!/bin/sh

CONFDIR="$DOTFILES/config"
HOMEDIR="$DOTFILES/home"
NIXOS=$([ -d /nix ] && echo true || echo false)

for file in $(ls -a "$CONFDIR"); do
    if [ "$file" = "." ] || [ "$file" = ".." ]; then
        continue
    fi

    if [ "$NIXOS" = true ]; then
        case "$file" in
        *gtk*)
            echo "Skipping $file (written by home manager)"
            continue
            ;;
        esac
    fi

    echo "Linking $file"
    source="$CONFDIR/$file"
    dest="$HOME/.config/$file"

    rm -rf "$dest"
    ln -sfn "$source" "$dest"
done

for file in $(ls -a "$HOMEDIR"); do
    if [ "$file" = "." ] || [ "$file" = ".." ]; then
        continue
    fi

    if [ "$NIXOS" = true ]; then
        case "$file" in
        *gtk*)
            echo "Skipping $file (written by home manager)"
            continue
            ;;
        esac
    fi

    echo "Linking $file"
    source="$HOMEDIR/$file"
    dest="$HOME/$file"

    rm -rf "$dest"
    ln -sfn "$source" "$dest"
done
