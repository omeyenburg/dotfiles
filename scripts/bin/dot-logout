#!/bin/sh
# shellcheck shell=bash

if pgrep wofi; then
    pkill wofi
    exit 0
fi

s0="        Lock"
s1="      Logout"
s2="      Reboot"
s3="    Shutdown"

conf=$HOME/.config/hypr/wofi/logout/config.toml
style=$HOME/.config/hypr/wofi/logout/style.css
output=$(echo -e "$s0\n$s1\n$s2\n$s3" | wofi --show dmenu --conf "$conf" --style "$style")

case "$output" in
    "$s0") loginctl lock-session ;;
    "$s1") hyprctl dispatch exit ;;
    "$s2") systemctl reboot ;;
    "$s3") systemctl poweroff ;;
esac
