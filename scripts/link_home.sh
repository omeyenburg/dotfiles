#!/bin/sh

CONFDIR="$(cd "$(dirname "$0")" && pwd)"/home

for file in $(ls -a $CONFDIR); do
    if [ "$file" = "." ] || [ "$file" = ".." ]; then
        continue
    fi

    echo "Linking: $file"
    source="$CONFDIR/$file"
    dest="$HOME/$file"

    rm -rf $dest
    ln -sfn $source $dest
done
