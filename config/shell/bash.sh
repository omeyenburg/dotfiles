#!/bin/sh
# shellcheck shell=bash

# Ignore duplicate commands in command history
export HISTCONTROL=ignoredups:erasedups
export HISTFILESIZE=100000
export HISTSIZE=10000

shopt -s histappend
shopt -s checkwinsize
shopt -s extglob
shopt -s globstar
shopt -s checkjobs

# Source /etc/bashrc for interactive shell configurations
if [ -z "$__ETC_BASHRC_SOURCED" ] && [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
