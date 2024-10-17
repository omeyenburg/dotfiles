#!/bin/sh

BASEDIR=$(dirname "$0")
HOMEDIR=$(realpath "$BASEDIR")/home

for file in $(ls -a $HOMEDIR); do
    if [ "$file" = "." ] || [ "$file" = ".." ]; then
        continue
    fi

    echo "Linking: $file"

    source="$HOMEDIR/$file"
    dest="$HOME/$file"

    rm -rf $dest
    ln -sfn $source $dest
done
