#!/bin/sh

# Import wal colors
source $HOME/.cache/wal/colors.sh

# Replace old color values
sed -i "0,/^text-color=.*/{s//text-color=${color7}/}" $HOME/.config/hypr/mako/config.toml
sed -i "0,/^border-color=.*/{s//border-color=${color5}AA/}" $HOME/.config/hypr/mako/config.toml
sed -i "0,/^background-color=.*/{s//background-color=${color1}EE/}" $HOME/.config/hypr/mako/config.toml

cat $HOME/.config/hypr/mako/config.toml
echo $color5
