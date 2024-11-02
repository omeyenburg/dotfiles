#!/bin/sh

CONFDIR="$DOTFILES/config"

for file in $(ls -a $CONFDIR); do
    if [ "$file" = "." ] || [ "$file" = ".." ]; then
        continue
    fi

    echo "Linking: $file"
    source="$CONFDIR/$file"
    dest="$HOME/.config/$file"

    rm -rf $dest
    ln -sfn $source $dest
done
