#!/bin/sh

# Wallpaper should be a path like: ~/Github/dotfiles/wallpapers/hyprland.jpg
wallpaper=${1:-""}
monitor=${2:-"eDP-1"}

# Select a random wallpaper if no wallpaper is provided.
if [ ! "$wallpaper" ]; then
    wallpaper=$(ls $HOME/.local/share/wallpapers/*.{png,PNG,jpg,JPG,jpeg,JPEG} 2>/dev/null | sort -R | tail -1)
fi

# These commands require "ipc" to be enabled
hyprctl hyprpaper unload "all" 1>/dev/null || (echo "Failed to unload wallpapers" && exit 1)
hyprctl hyprpaper preload "$wallpaper" 1>/dev/null || (echo "Failed to preload wallpaper" && exit 1)
hyprctl hyprpaper wallpaper "$monitor,$wallpaper" 1>/dev/null || (echo "Failed to apply wallpaper" && exit 1)
