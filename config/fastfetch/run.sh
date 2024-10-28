#!/bin/sh

os=$(uname -o)
if [ "$os" = "Android" ]; then
    FASTFETCHSTART=1
    logo="android"
    cols=100
    args="--logo-position top --logo-padding-left 18 --logo-padding-top 1 --logo-padding-right 2"
    clear
elif [ "$os" = "GNU/Linux" ]; then
    logo=$(grep "^ID=" /etc/*-release | sed 's/ID="//;s/-.*//;s/"//')
    cols=$(tput cols)
    args=""
else
    echo "StartFastfetch: $os not yet supported"
fi

if [ ${FASTFETCHSTART:-} ] && [ "${logo:-''}" ]; then
    if [ $cols -ge 71 ]; then
        fastfetch -l "${logo}_small" $args
    elif [ $cols -ge 56 ]; then
        fastfetch -l none $args
    fi
fi
