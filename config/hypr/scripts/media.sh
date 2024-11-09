#!/bin/sh

if [ "$1" = "volume" ]; then
    if [ "$2" = "up" ]; then
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    elif [ "$2" = "down" ]; then
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    elif [ "$2" = "toggle" ]; then
        title="Volume (Muted)"
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    else
        echo "Invalid value '$2'. Valid values are: up, down, toggle"
        exit 1
    fi

    muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ print $3 }')
    percent=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ print 100 * $2 }')

    if [ "$muted" ]; then
        title="Volume (muted)"
    else
        title="Volume"
    fi
elif [ "$1" = "screen-brightness" ]; then
    if [ "$2" = "up" ]; then
        brightnessctl set 5%+ > /dev/null
    elif [ "$2" = "down" ]; then
        brightnessctl set 5%- > /dev/null
    else
        echo "Invalid value '$2'. Valid values are: up, down"
        exit 1
    fi

    title="Screen Brightness"
    current=$(brightnessctl g)
    max=$(brightnessctl m)
    percent=$(echo "100*$current/$max" | bc)
elif [ "$1" = "keyboard-brightness" ]; then
    if [ "$2" = "up" ]; then
        brightnessctl -d smc::kbd_backlight set 10%+
    elif [ "$2" = "down" ]; then
        brightnessctl -d smc::kbd_backlight set 10%-
    else
        echo "Invalid value '$2'. Valid values are: up, down"
        exit 1
    fi

    title="Keyboard Brightness"
    current=$(brightnessctl -d smc::kbd_backlight get)
    max=$(brightnessctl -d smc::kbd_backlight max)
    percent=$(echo "100*$current/$max" | bc)
else
    echo "Invalid value '$1'. Valid values are: volume, screen-brightness, keyboard-brightness"
    exit 1
fi

# killall -9 AppRun.wrapped
# killall -9 zenity
# $HOME/.local/bin/yad --progress --title="info-overlay" --text="$title" --text-align="center" --timeout=1 --no-buttons --borders=12 $percent
# old=$(ps -e | grep zenity | head -1 | awk '{ print $1 }')
# zenity --progress --title="Volume" --text="" --timeout=1 --percentage=1 --no-cancel --ok-label="$percent%" --height=130 &
# sleep 0.2
# if [ "$old" ]; then
#     echo "killing $old"
#     kill $old
# fi
# pid=$(ps aux | grep "hypr/scripts/overlay.py" | awk '{ print $2 }')
# sleep 0.2
# kill -9 $pid

echo $percent > /tmp/hypr-overlay-pipe
running=$(ps aux | grep "python3.*hypr/scripts/overlay.py" | wc -l)
if [ $running -le 1 ]; then
    python3 $HOME/.config/hypr/scripts/overlay.py $percent
fi
