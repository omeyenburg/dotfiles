#!/bin/sh

CONFIG="tmp.cnf"

echo "Configuring dotfiles setup"

if [ -e $CONFIG ]; then
    echo "A config file already exists."
    read -p "Continue and overwrite? (y/n)" confirm
    echo $confirm

    if [[ "$confirm" == ^(y|Y)$ ]]; then
        exit 1
    fi
fi

echo "" > $CONFIG
