#!/bin/sh

# ="$(cd "$(dirname "$0")" && pwd)"/config
CONFDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"/../config

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
