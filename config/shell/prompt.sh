#!/bin/sh
# shellcheck shell=bash

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
