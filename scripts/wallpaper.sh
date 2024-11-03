#!/bin/sh

WALLPAPER_DIRECTORY="$HOME/.local/share/wallpapers/"

mkdir -p $HOME/.local/share/wallpapers/
cp "$DOTFILES"wallpapers/*.{png,PNG,jpg,JPG,jpeg,JPEG} $WALLPAPER_DIRECTORY 2>/dev/null || (echo "Failed to copy wallpapers" && exit 1)
echo "Copied wallpapers into $WALLPAPER_DIRECTORY"
