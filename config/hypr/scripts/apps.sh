#!/bin/sh

if [ "$(ps -e | grep wofi)" ]; then
    pkill wofi
    exit 0
fi

cd $HOME
wofi --show drun --conf $HOME/.config/hypr/wofi/apps/config.toml --style $HOME/.config/hypr/wofi/apps/style.css
