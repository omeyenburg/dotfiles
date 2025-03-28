#!/bin/sh

# Fastfetch
. $HOME/.config/fastfetch/run.sh

# Add ~/.local/bin to path
export PATH="$PATH:$HOME/.local/bin"

# macOS-specific settings
if [ "$(uname)" = "Darwin" ]; then
    # Disable homebrew autoupdate
    export HOMEBREW_NO_AUTO_UPDATE=1

    # Enable terminal colors
    [[ -n "$DISPLAY" && "$TERM" = "xterm" ]] && export TERM=xterm-256color
fi

if [[ "$SHELL" = */bin/bash ]]; then
    # Ignore duplicate commands in command history
    export HISTCONTROL=ignoredups:erasedups

    # Source /etc/bashrc for interactive shell configurations
    if [ -f /etc/bashrc ]; then
        . /etc/bashrc
    fi
elif [ "$SHELL" = "/bin/zsh" ]; then
    # Ignore duplicate commands in command history
    setopt HIST_IGNORE_ALL_DUPS
fi

eval "$(direnv hook bash)"
export DIRENV_LOG_FORMAT=""

# Source shared config
. "$HOME"/.config/shell/shared.sh
