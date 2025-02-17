#!/bin/sh

# Wallpaper should be a path like: ~/Github/dotfiles/wallpapers/hyprland.jpg
wallpaper=${1:-""}
monitor=${2:-"eDP-1"}

# Return current wallpaper
get_wallpaper () {
    cat "$HOME/.cache/wal/wal"
    echo ""
}

# Search wallpapers
list_wallpapers () {
    ls "$HOME/.local/share/wallpapers/*" 2> /dev/null
}

# Select a random wallpaper if no wallpaper is provided.
if [ ! "$wallpaper" ]; then
    wallpaper=$(list_wallpapers | sort -R | tail -1)
elif [ "$wallpaper" = "get" ]; then
    get_wallpaper
    exit 0
elif [ "$wallpaper" = "list" ]; then
    echo "Found wallpapers:"
    for file in $(list_wallpapers)
    do
        echo "  $file"
    done
    exit 0
fi

echo "Using wallpaper $wallpaper"
# $HOME/.config/hypr/scripts/notify.sh "" "$wallpaper"

# Kill waybar before changing wallpaper
pkill waybar

# Start hyprpaper if not running yet
if [ ! "$(ps -e | grep hyprpaper )" ]; then
    echo "Starting hyprpaper"
    hyprpaper # --config .config/hypr/conf/wallpaper.conf & disown
    sleep 0.1
fi

# Try loading wallpaper
for ((i = 1; i <= 2; i++)); do
    # These commands require "ipc" in hyprpaper to be enabled
    success=$(timeout 1 bash -c "{ hyprctl hyprpaper unload 'all'; hyprctl hyprpaper preload $wallpaper; hyprctl hyprpaper wallpaper $monitor,$wallpaper; }" )

    if [ $? -eq 0 ]; then
        echo "Successfully loaded wallpaper"
        break
    elif [ $i == 1 ]; then
        echo "Retrying to load wallpaper"
        echo "Reason: $success"
        pkill hyprpaper
        hyprpaper # --config .config/hypr/conf/wallpaper.conf & disown
    else
        echo "Failed to load wallpaper"
        exit 1
    fi
done

# Detect wallpaper brightness
brightness=$(magick "$wallpaper" -colorspace Gray -format "%[fx:mean*255]" info:)
if (( $(echo "$brightness > 50" | bc -l) )); then
    light="-l"
else
    light=""
fi

# Generate colorscheme
$(which wal) -i "$wallpaper" -stqn $light --saturate 0.1

# Relaunch waybar (kill again for spam protection)
# pkill waybar
# waybar --config $HOME/.config/hypr/waybar/config.jsonc --style $HOME/.config/hypr/waybar/style.css & disown
"$HOME/.config/hypr/scripts/waybar.sh" start

# Reload mako
echo "Reloading mako"
"$HOME/.config/hypr/mako/colors-wal.sh"
makoctl reload
