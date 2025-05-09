#!/bin/sh
# shellcheck shell=bash

# If not running interactively, don't do anything
[[ $- == *i* ]] || return

export EDITOR=nvim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="$PATH:$HOME/.local/bin"

# macOS-specific settings
if [ "$(uname)" = "Darwin" ]; then
    # Disable homebrew autoupdate
    export HOMEBREW_NO_AUTO_UPDATE=1

    # Enable terminal colors
    [[ -n "$DISPLAY" && "$TERM" = "xterm" ]] && export TERM=xterm-256color
fi

# shell specific settings
if [[ "$SHELL" = */bin/bash ]]; then
    . "$HOME/.config/shell/bash.sh"
elif [ "$SHELL" = "/bin/zsh" ]; then
    . "$HOME/.config/shell/zsh.sh"
fi

# initialize direnv
if command -v direnv &>/dev/null; then
    eval "$(direnv hook bash)"
    export DIRENV_LOG_FORMAT=""
fi

# initialize zoxide
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash --cmd cd)"
    alias z=__zoxide_z
    alias zi=__zoxide_zi
    alias b="cd -"
fi

alias git="LANG=en_GB git"
alias gitlog="python3 ~/.config/shell/gitlog.py"
alias la="ls -A"
alias ll="ls -alF"
alias books="librewolf file:///home/oskar/books && exit"

# Tmux sessions
alias t=~/.config/tmux/t.sh
complete -W "exit kill $(t list)" t

# Obsidian vaults
obsidianopen() {
    obsidian "obsidian://open?vault=$1" &
    disown
}

# Yazi
y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# Custom shell promt
. "$HOME"/.config/shell/prompt.sh
