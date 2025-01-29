#!/bin/sh

export EDITOR=nvim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ls
alias ll="ls -alF"
alias la="ls -A"

# Git
alias git="LANG=en_GB git"
alias gitlog="python3 ~/.config/shell/gitlog.py"

# Ollama
alias deepseek="ollama run deepseek-r1:1.5b"

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
bold_purple='\e[1;35m'
bold_cyan="\e[1;36m"
bold_green='\e[1;32m'
bold_blue='\e[1;34m'

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ on  \1/'
}

parse_nix_shell() {
    if [[ $SHELL = /nix* ]]; then
        echo " via nix shell"
    fi
}

export PS1="${bold_cyan}\w${bold_purple}\$(parse_git_branch)${bold_blue}\$(parse_nix_shell)\n${bold_green}❯ \e[0m"
