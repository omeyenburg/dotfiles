#!/usr/bin/env bash

session=mcli
repo=~/git/mcli/

# Check if the session already exists
tmux has-session -t $session 2>/dev/null

# $? is the exit status of the last command
if [ $? != 0 ]; then
    tmux new-session -d -s $session -c "$repo"

    tmux new-window -t $session:1
    tmux send-keys -t $session:1 'source venv/bin/activate;clear' C-m

    tmux new-window -t $session:2 -c "$repo"
    tmux send-keys -t $session:2 'source venv/bin/activate;clear' C-m

    tmux new-window -t $session:3 -c "$repo"
    tmux send-keys -t $session:3 'source venv/bin/activate;clear' C-m

    tmux select-window -t $session:1
fi

# Attach to the tmux session
tmux attach -t $session
