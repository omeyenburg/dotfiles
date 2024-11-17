#!/bin/sh

# Wallpaper should be a path like: ~/Github/dotfiles/wallpapers/hyprland.jpg
wallpaper=${1:-""}
monitor=${2:-"eDP-1"}

# Search wallpapers
function list_wallpapers {
    ls $HOME/.local/share/wallpapers/*.{png,PNG,jpg,JPG,jpeg,JPEG} 2> /dev/null
}

# Select a random wallpaper if no wallpaper is provided.
if [ ! "$wallpaper" ]; then
    wallpaper=$(list_wallpapers | sort -R | tail -1)
elif [ "$wallpaper" == "list" ]; then
    echo "Found wallpapers:"
    for file in $(list_wallpapers)
    do
        echo "    $file"
    done
    exit 0
fi
echo "Using wallpaper $wallpaper"

# Kill waybar before changing wallpaper
killall waybar

# These commands require "ipc" in hyprpaper to be enabled
timeout 1 hyprctl hyprpaper unload "all" 1>/dev/null || { pkill hyprpaper; hyprpaper --config $hypr/conf/wallpaper.conf & disown; }
hyprctl hyprpaper preload "$wallpaper" 1>/dev/null || (echo "Failed to preload wallpaper" && exit 1)
hyprctl hyprpaper wallpaper "$monitor,$wallpaper" 1>/dev/null || (echo "Failed to apply wallpaper" && exit 1)

# Detect wallpaper brightness
brightness=$(magick "$wallpaper" -colorspace Gray -format "%[fx:mean*255]" info:)
if (( $(echo "$BRIGHTNESS > 50" | bc -l) )); then
    light="-l"
else
    light=""
fi

# Generate colorscheme
wal -i $wallpaper -stqn $light --saturate 0.1

# Relaunch waybar (kill again for spam protection)
killall waybar
waybar --config $HOME/.config/hypr/waybar/config.jsonc --style $HOME/.config/hypr/waybar/style.css & disown

# Reload mako
echo "Reloading mako"
$HOME/.config/hypr/mako/colors-wal.sh
makoctl reload
