#!/usr/bin/env bash

export EDITOR=nvim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

alias git="LANG=en_GB git"
alias gitlog="python3 ~/.config/shell/gitlog.py"
alias la="ls -A"
alias ll="ls -alF"

# After suspend wifi sometimes does not work.
# Quick-and-dirty fix is to remove the wifi device and rescan.
reloadwifi() {
    sudo sh -c '( echo 1 > /sys/bus/pci/devices/0000:03:00.0/remove || : ) && sleep 0.1 && echo 1 > /sys/bus/pci/rescan'
}

# Tmux sessions
alias t=~/.config/tmux/t.sh
complete -W "exit kill $(t list)" t

# Obsidian vaults
obsidianopen() {
    obsidian "obsidian://open?vault=$1" & disown
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

# Custom shell prompt
# Colors are surrounded with octal codes instead
# of \[ and \], because these are bash specific.
default_color='\001\033[0m\002'
bold_red='\001\033[0;31m\002'
bold_green='\001\033[0;32m\002'
bold_blue='\001\033[0;34m\002'
bold_purple='\001\033[0;35m\002'
bold_cyan='\001\033[0;36m\002'

parse_git_branch() {
    branch=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/;s/(HEAD \(.*\))/\1/')

    if [[ $branch ]]; then
        echo -e "${default_color} on ${bold_purple} $branch"
    fi
}

parse_nix_shell() {
    if [[ $SHELL = /nix* ]]; then
        echo -e "${default_color} via ${bold_blue} nix shell"
    fi
}

parse_root() {
    if [ "$(whoami)" = "root" ]; then
        echo -e "${default_color} as ${bold_red}root"
    fi
}

export PROMPT_DIRTRIM=3
export PS1="${bold_cyan}\w\$(parse_git_branch)\$(parse_nix_shell)\$(parse_root)\n${bold_green}❯${default_color} "
