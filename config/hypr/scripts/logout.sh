#!/bin/sh

if [ "$(ps -e | grep wofi)" ]; then
    pkill wofi
    exit 0
fi

S0="          Lock"
S1="        Logout"
S2="        Reboot"
S3="      Shutdown"
S4="         Gnome"

cd $HOME/.config/hypr/wofi/logout
OUTPUT=$(echo -e "$S0\n$S1\n$S2\n$S3\n$S4" | wofi --show dmenu --conf config.toml --style style.css)

case "$OUTPUT" in
    "$S0") swaylock --config $HOME/.config/hypr/swaylock/config.toml ;;
    "$S1") hyprctl dispatch exit ;;
    "$S2") systemctl reboot ;;
    "$S3") systemctl poweroff ;;
    "$S4") XDG_CURRENT_DESKTOP=GNOME gnome-control-center --verbose ;;
    *) ;;
esac
