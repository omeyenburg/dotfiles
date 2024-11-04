#!/bin/sh

if [ "$(ps -e | grep wofi)" ]; then
    pkill wofi
    exit 0
fi

s0="          Lock"
s1="        Logout"
s2="        Reboot"
s3="      Shutdown"
s4="         Gnome"

conf=$HOME/.config/hypr/wofi/logout/config.toml
style=$HOME/.config/hypr/wofi/logout/style.css
output=$(echo -e "$s0\n$s1\n$s2\n$s3\n$s4" | wofi --show dmenu --conf $conf --style $style)

case "$output" in
    "$s0") swaylock --config $HOME/.config/hypr/swaylock/config.toml ;;
    "$s1") hyprctl dispatch exit ;;
    "$s2") systemctl reboot ;;
    "$s3") systemctl poweroff ;;
    "$s4") XDG_CURRENT_DESKTOP=GNOME gnome-control-center --verbose ;;
    *) ;;
esac
