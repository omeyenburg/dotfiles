#!/bin/sh

if [ "$(ps -e | grep wofi)" ]; then
    exit 0;
fi

cd $HOME/.config/wofi/apps
wofi --show drun --conf config.toml --style style.css
