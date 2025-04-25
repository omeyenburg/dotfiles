#!/bin/sh

source scripts/utils/err.sh

if [ ! -f ~/.config/tmux/tmux.conf ]; then
    err "Please run \`make link\` first."
fi

SCRIPT_NAME="tmux.sh"
PLUGINS=$HOME/.tmux/plugins

(
    echo Installing tpm
    mkdir -p "$PLUGINS" && cd "$PLUGINS" || err "Failed to create $PLUGINS"
    cd tpm && git pull ||
        git clone git@github.com:tmux-plugins/tpm "$HOME"/.tmux/plugins/tpm ||
        err "Could not clone tpm"

    cd "$PLUGINS"
    echo Installing plugins
    source "$PLUGINS"/tpm/scripts/install_plugins.sh || err "Failed to install plugins"
)

# Check whether catppuccin is actively used in config
if grep "run ~/.tmux/plugins/catppuccin/catppuccin.tmux" config/tmux/tmux.conf > /dev/null; then
    git clone git@github.com:catppuccin/tmux.git ~/.tmux/plugins/catppuccin
fi
