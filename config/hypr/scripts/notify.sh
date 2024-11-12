#!/bin/sh

# Notification app name
appname=${1:-"default_app"}

# Notification title
title=${2:-"No Title"}

# Notification message
message=${3:-"No message provided"}

# Timeout in ms
timeout=${4:-5000}

# Urgency levels: 0 = low, 1 = normal, 2 = critical
urgency=${5:-0}

# The id to overwrite
id=${6:-0}

# Send notification using busctl
id=$(busctl --user call \
    org.freedesktop.Notifications \
    /org/freedesktop/Notifications \
    org.freedesktop.Notifications \
    Notify "susssasa{sv}i" \
    "$appname" "$id" "" "$title" "$message" \
    0 1 \
    "urgency" "i" "$urgency" \
    "$timeout")

# Return id of notification
echo $(echo "$id" | sed "s/u\s//")
