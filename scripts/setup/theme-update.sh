#!/usr/bin/env bash

THEME=$HOME/.config/hypr/themes/current.css

WAYBAR_STYLE=$HOME/.config/waybar/style.css
WOFI_APPS_STYLE=$HOME/.config/wofi/apps/style.css
WOFI_LOGOUT_STYLE=$HOME/.config/wofi/logout/style.css

compile() {
    local style=$1

    {
        cat "$THEME"
        echo
        cat "$style".template
    } >"$style"
}

compile "$WAYBAR_STYLE"
compile "$WOFI_APPS_STYLE"
compile "$WOFI_LOGOUT_STYLE"
