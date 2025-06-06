#!/bin/sh

# Notification app name
appname=${1:-"default_app"}

# Notification title (mako will not show if set to notitle)
title=${2:-"notitle"}

# Notification message
message=${3:-"No message provided"}

# Timeout in ms
timeout=${4:-5000}

# Urgency levels: 0 = low, 1 = normal, 2 = critical
urgency=${5:-0}

# The message id to override
message_id=${6:-0}

# Send notification using busctl
message_id=$(busctl --user call \
    org.freedesktop.Notifications \
    /org/freedesktop/Notifications \
    org.freedesktop.Notifications \
    Notify "susssasa{sv}i" \
    "$appname" "$message_id" "" "$title" "$message" \
    0 1 \
    "urgency" "i" "$urgency" \
    "$timeout")

# Return id of notification
echo "$message_id" | sed "s/u\s//"
