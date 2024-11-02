#!/bin/sh

if [ "$(ps -e | grep wofi)" ]; then
    pkill wofi
    exit 0
fi

cd $HOME/.config/hypr/wofi/apps
wofi --show drun --conf config.toml --style style.css
