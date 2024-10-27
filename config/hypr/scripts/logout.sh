#!/bin/sh

if [ "$(ps -e | grep wofi)" ]; then
    pkill wofi
    exit 0
fi

S0="          Lock"
S1="        Logout"
S2="        Reboot"
S3="      Shutdown"
S4="     Processes"
S5="      Settings"

cd $HOME/.config/wofi/logout
OUTPUT=$(echo -e "$S0\n$S1\n$S2\n$S3\n$S4\n$S5" | wofi --show dmenu --conf config.toml --style style.css)

case "$OUTPUT" in
    "$S0") swaylock ;;
    "$S1") hyprctl dispatch exit ;;
    "$S2") systemctl reboot ;;
    "$S3") systemctl poweroff ;;
    "$S4") killall btop || alacritty -e btop ;;
    *) ;;
esac
