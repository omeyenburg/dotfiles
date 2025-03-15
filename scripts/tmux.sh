#!/bin/sh
source scripts/err.sh

SCRIPT_NAME="tmux.sh"
PLUGINS=$HOME/.tmux/plugins

(
    echo Installing tpm
    mkdir -p "$PLUGINS" && cd "$PLUGINS" || err "Failed to create $PLUGINS"
    cd tpm && git pull ||
        git clone git@github.com:tmux-plugins/tpm $HOME/.tmux/plugins/tpm ||
        err "Could not clone tpm"

    cd "$PLUGINS"
    echo Installing plugins
    source "$PLUGINS"/tpm/scripts/install_plugins.sh || err "Failed to install plugins"
)
