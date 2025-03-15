#!/bin/sh

QMKHOME="$HOME/.qmk_firmware"

if [ ! -d "$QMKHOME" ]; then
    echo "$QMKHOME does not exist. Run \"qmk setup\" first."
    exit 1
fi

for dir in "$DOTFILES"keyboards/*; do
    if [ ! -d "$dir" ]; then
        echo "$dir is not a directory."
        continue
    fi

    name=$(basename "$dir")
    echo "Linking $name..."

    if [ -L "$QMKHOME/keyboards/$name" ]; then
        echo "$QMKHOME/keyboards/$name already exists (symlink)"
        echo "$name will not be linked."
        continue
    fi
    if [ -d "$QMKHOME/keyboards/$name" ]; then
        echo "$QMKHOME/keyboards/$name already exists (directory)"
        echo "$name will not be linked."
        continue
    fi

    ln -s "$dir" "$QMKHOME/keyboards/$name"
    echo "Successully created symlink for $name"
done
