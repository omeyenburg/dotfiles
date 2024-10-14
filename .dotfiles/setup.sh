#!/bin/bash

# Set up git configuration
git config --global user.name "omeyemburg"
git config --global user.email "135001586+omeyenburg@users.noreply.github.com"
git config --global core.editor "vim"
git config --global core.excludesfile "~/.config/git/gitignore_global"
git config --global fetch.autoFetch true
git config --global color.ui true
git config --global init.defaultBranch main

# Add other setup commands as needed
# For example, configuring aliases or other tools

echo "Git configuration applied!"
