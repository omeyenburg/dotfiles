#!/bin/sh

WALLPAPER_DIRECTORY="$HOME/.local/share/wallpapers/"
action=$1

if [ "$action" == "list" ]; then
    echo "Wallpapers in $WALLPAPER_DIRECTORY:"
    ls $WALLPAPER_DIRECTORY -1 --color=always
elif [ "$action" == "install" ]; then
    mkdir -p $HOME/.local/share/wallpapers/
    cp "$DOTFILES"wallpapers/*.{png,PNG,jpg,JPG,jpeg,JPEG} $WALLPAPER_DIRECTORY 2>/dev/null || :
    echo "Copied wallpapers into $WALLPAPER_DIRECTORY"
else
    echo "Please specify a valid option: list, install or switch."
fi
