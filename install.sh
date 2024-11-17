#!/bin/sh

WALLPAPER_DIRECTORY="$HOME/.local/share/wallpapers/"

# This only copies the wallpapers into the ~/.local/share/wallpapers
# Old wallpapers will not be deleted unless they are overwritten
mkdir -p $WALLPAPER_DIRECTORY
cp ./wallpapers/* $WALLPAPER_DIRECTORY 2>/dev/null
echo "Copied wallpapers into $WALLPAPER_DIRECTORY"
