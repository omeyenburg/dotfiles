#!/bin/bash

chosen=$(echo -e "Lock\nLogout\nReboot\nShutdown" | wofi --dmenu --prompt "Choose action: " --lines=5 --no-input)

case "$chosen" in
    Lock) swaylock ;;
    Logout) hyprctl dispatch exit ;;
    Reboot) systemctl reboot ;;
    Shutdown) systemctl poweroff ;;
    *) ;;
esac
