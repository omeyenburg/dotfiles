#!/bin/sh
# shellcheck shell=bash

# include .profile if it exists
[[ -f ~/.profile ]] && . ~/.profile

# include session if it exists
session="$HOME/.config/shell/session.sh"
[[ -r "$session" ]] && . "$session"
