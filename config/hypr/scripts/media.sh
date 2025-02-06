#!/bin/sh

timeout=1
pipe="/tmp/hyprland-media-pipe"

if [ "$1" = "volume" ]; then
    if [ "$2" = "up" ]; then
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    elif [ "$2" = "down" ]; then
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    elif [ "$2" = "toggle" ]; then
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    elif [ "$2" = "get" ]; then
        wpctl get-volume @DEFAULT_AUDIO_SINK@
        exit 1
    else
        echo "Invalid value '$2'. Valid values are: up, down, toggle, get"
        exit 1
    fi

    muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ print $3 }')
    percent=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ print 100 * $2 }')

    if [ "$muted" ]; then
        text="Volume muted"
    else
        text="Volume"
    fi
elif [ "$1" = "display-brightness" ]; then
    if [ "$2" = "up" ]; then
        brightnessctl set 5%+ > /dev/null
    elif [ "$2" = "down" ]; then
        brightnessctl set 5%- > /dev/null
    else
        echo "Invalid value '$2'. Valid values are: up, down"
        exit 1
    fi

    text="Display Brightness"
    current=$(brightnessctl g)
    max=$(brightnessctl m)
    percent=$((100*current/max))
elif [ "$1" = "keyboard-brightness" ]; then
    if [ "$2" = "up" ]; then
        brightnessctl -d smc::kbd_backlight set 10%+
    elif [ "$2" = "down" ]; then
        brightnessctl -d smc::kbd_backlight set 10%-
    else
        echo "Invalid value '$2'. Valid values are: up, down"
        exit 1
    fi

    text="Keyboard Brightness"
    current=$(brightnessctl -d smc::kbd_backlight get)
    max=$(brightnessctl -d smc::kbd_backlight max)
    percent=$((100*current/max))
else
    echo "Invalid value '$1'. Valid values are: volume, display-brightness, keyboard-brightness"
    exit 1
fi

# Create the named pipe if it doesn't exist
if [ ! -p "$pipe" ]; then
    mkfifo "$pipe"
fi

# Reset the timeout
pkill -f .config/hypr/scripts/timeout.sh

# Write to pipe
echo "$percent" > $pipe & # Write in background waiting for read
exec 3<>$pipe # Open for read write
echo "$percent" >&3 # Write to open pipe

# Check if yad is already running
title=$(echo "Media$text" | sed "s/ //g")
yad_pid=$(pgrep -f "yad.*--title $title " | head -1)
if [ -z "$yad_pid" ]; then
    # Kill other yad processes
    pkill -f "yad.*--title"

    # Start YAD and read from the pipe
    # Just using "... < $pipe" also works, but this seems to be faster for some reason
    yad --progress --no-buttons --fixed --window-type=splash --on-top \
        --text "$text" --title "$title" --text-align center < <(stdbuf -o0 cat "$pipe") &
fi

# Create new timeout
"$HOME/.config/hypr/scripts/timeout.sh" "$timeout" "yad.*--title $title" &
