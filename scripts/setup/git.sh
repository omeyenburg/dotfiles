#!/usr/bin/env bash

# Set up git configuration
git config --global user.name "omeyenburg"
git config --global user.email "omeyenburg@gmail.com"
git config --global core.editor "nvim"
git config --global core.excludesfile "~/.config/git/gitignore_global"
git config --global fetch.autoFetch true
git config --global color.ui true
git config --global init.defaultBranch main

echo "Git configuration applied."
