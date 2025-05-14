#!/bin/sh

if [ ! "$1" ]; then
    echo "No app name provided"
    exit 1
fi

app=$1
desktop_files=$HOME/.local/share/applications
desktop_file=$(grep -lr --include="*.desktop" -E "^Name=${app}$" "$desktop_files" | head -1)
command=$(sed -n '/^Exec=/ {s///;p;q}' "$desktop_file")
$command
