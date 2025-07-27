#!/usr/bin/env bash

arg=$1

if [ "$arg" = "list" ]; then
    echo $(ls ~/.config/tmux/repos/ | sed 's/.sh//' | tr '\n' ' ')
elif [ "$arg" = "kill" ]; then
    tmux kill-server
elif [ "$arg" = "exit" ]; then
    tmux kill-session
elif [ "$arg" ]; then
    ~/.config/tmux/repos/"$arg".sh
fi
