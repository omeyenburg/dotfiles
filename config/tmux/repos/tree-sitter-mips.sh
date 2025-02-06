#!/bin/sh

session="mips-ts"

# Check if the session already exists
tmux has-session -t $session 2>/dev/null

# $? is the exit status of the last command
if [ $? != 0 ]; then
    tmux new-session -d -s $session -c ~/git/tree-sitter-mips/

    tmux new-window -t $session:1
    tmux new-window -t $session:2
    tmux new-window -t $session:3

    tmux select-window -t $session:1
fi

# Attach to the tmux session
tmux attach -t $session
