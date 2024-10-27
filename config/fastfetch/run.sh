#!/bin/sh

if [ -n "$ALACRITTY_LOG" ] && [ -z "$TMUX" ] && [ -z "$SSH_TTY" ] && [[ $- == *i* ]]; then
    cols=$(tput cols)
    
    # other logos
    # tumbleweed
    # opensuse
    if [ $cols -ge 71 ]; then
        fastfetch -l opensuse_small
    elif [ $cols -ge 56 ]; then
        fastfetch -l none
    fi
fi
