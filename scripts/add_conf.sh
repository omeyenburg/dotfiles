#!/bin/sh

(
    source scripts/err.sh

    SCRIPT_NAME="add_conf.sh"

    name=$1

    if [ ! "$name" ]; then
        err "No config name provided."
    fi

    CONFDIR="$DOTFILES/config

    mv -i "$HOME/.config/$name" "$CONFDIR" || err "Failed to move config file."

    echo "Moved config."
    echo "You should now reinstall it by running scripts/link_conf.sh"
)
