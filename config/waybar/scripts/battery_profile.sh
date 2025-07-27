#!/usr/bin/env bash

# Get current power profile
power_profile=$(powerprofilesctl get || exit)

# Cycle through power profiles
case $power_profile in
    "performance")
        powerprofilesctl set balanced
        ;;
    "balanced")
        powerprofilesctl set power-saver
        ;;
    "power-saver")
        powerprofilesctl set performance
        ;;
    *)
        powerprofilesctl set power-saver
        ;;
esac

# Refresh module
pkill -RTMIN+8 waybar
