#!/bin/sh

os=$(uname -o)
if [ "$os" = "Android" ]; then
    FASTFETCHSTART=1
    cols=100
    args="--logo-position top --logo-padding-left 18 --logo-padding-top 1 --logo-padding-right 2"
    clear
elif [ "$os" = "GNU/Linux" ]; then
    cols=$(tput cols)
    args=""
    # distro=$(grep "^ID=" /etc/*-release | sed 's/ID="//;s/-.*//;s/"//')
    distro=$(grep "^ID=" /etc/*-release | sed 's/.*ID=//')
    if [ "$distro" = "nixos" ]; then
        args="$args -l none"
    fi
else
    echo "StartFastfetch: $os not yet supported"
fi

if [ "${FASTFETCHSTART:-}" ]; then
    if [ "$cols" -ge 71 ]; then
        fastfetch -l small --logo-type builtin $args
    elif [ "$cols" -ge 56 ]; then
        fastfetch -l none $args
    fi
fi
