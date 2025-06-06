#!/bin/sh

# Start, toggle and stop waybar

start() {
    (
        waybar --config "$HOME/.config/hypr/waybar/config.jsonc" --style "$HOME/.config/hypr/waybar/style.css" &
        disown
    )
}

stop() {
    pkill -o waybar-wrapped
}

if [ "$1" = "start" ]; then
    stop
    start
elif [ "$1" = "stop" ]; then
    stop
else
    stop || start
fi
