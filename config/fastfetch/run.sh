#!/bin/sh

os=$(uname -o)
if [ "$os" = "Android" ]; then
    FASTFETCHSTART=1
    logo="android"
    position="top"
    lpadding=18
elif [ "$os" = "GNU/Linux" ]; then
    logo=$(grep "^ID=" /etc/*-release | sed 's/ID="//;s/-.*//;s/"//')
    position="left"
    lpadding=2
else
    echo "StartFastfetch: $os not yet supported"
fi

if [ ${FASTFETCHSTART:-} ] && [ "${logo:-''}" ]; then
    cols=$(tput cols)

    args="--logo-position $position --logo-padding-left $lpadding"
    if [ $cols -ge 71 ]; then
        fastfetch -l "${logo}_small" $args
    elif [ $cols -ge 56 ]; then
        fastfetch -l none $args
    fi
fi
