#!/bin/sh

PLUGINS=$HOME/.tmux/plugins

(
    mkdir -p $PLUGINS && cd $PLUGINS || echo "Tmux setup: Failed to create $PLUGINS" && exit 1
    git pull || git clone git@github.com:tmux-plugins/tpm $HOME/.tmux/plugins/tpm
)
