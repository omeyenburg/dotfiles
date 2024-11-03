#!/bin/sh

handle() {
    case $1 in
    windowtitle*)
        # Extract the window ID from the line
        window_id=${1#*>>}

        # Fetch the list of windows and parse it using jq to find the window by its decimal ID
        window_info=$(hyprctl clients -j | jq --arg id "0x$window_id" '.[] | select(.address == ($id))')

        # Extract the title from the window info
        window_title=$(echo "$window_info" | jq '.title')

        # Check if the title matches the characteristics of the Bitwarden popup window
        if [[ "$window_title" == *"(Bitwarden Password Manager)"* ]]; then

            # Check if window is already floating (not strictly necessary)
            if [[ "$(echo "$window_info" | jq -r '.floating')" == "false" ]]; then
                # Calculate monitor center
                monitors=$(hyprctl monitors -j)
                x=$(echo $monitors | jq -r '.[].x')
                y=$(echo $monitors | jq -r '.[].y')
                w=$(echo $monitors | jq -r '.[].width')
                h=$(echo $monitors | jq -r '.[].height')
                s=$(echo $monitors | jq -r '.[].scale')

                hyprctl dispatch setfloating address:0x$window_id
                hyprctl dispatch resizewindowpixel exact 20% 50%,address:0x$window_id
                hyprctl dispatch centerwindow address:0x$window_id
                hyprctl dispatch movecursor $(echo "$x / $s + $w / 2" | bc) $(echo "$y / $s + $h / 2" | bc)
            fi
        fi
        ;;
    esac
}

# Listen to the Hyprland socket for events and process each line with the handle function
socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
