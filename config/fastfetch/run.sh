#!/bin/sh

if [ ${FASTFETCHSTART:-} ]; then
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
