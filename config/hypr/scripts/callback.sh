#!/usr/bin/env bash

handle() {
    case $1 in
      windowtitle*)
        ## Bitwarden : floating and centered ##

        # Extract the window ID from the line
        window_id=${1#*>>}

        # Fetch the list of windows and parse it using jq to find the window by its decimal ID
        window_info=$(hyprctl clients -j | jq --arg id "0x$window_id" '.[] | select(.address == ($id))')

        # Check if window is floating
        if [ "$(echo "$window_info" | jq -r '.floating')" = "false" ]; then

            # Extract the title from the window info
            window_title=$(echo "$window_info" | jq '.title')

            # Check if window is from Bitwarden
            if [[ "$window_title" == *"(Bitwarden Password Manager)"* ]]; then

                # Calculate monitor center
                monitors=$(hyprctl monitors -j)
                monitor_id=$(hyprctl activeworkspace -j | jq '.monitorID')
                x=$(echo "$monitors" | jq -r ".[$monitor_id].x")
                y=$(echo "$monitors" | jq -r ".[$monitor_id].y")
                w=$(echo "$monitors" | jq -r ".[$monitor_id].width")
                h=$(echo "$monitors" | jq -r ".[$monitor_id].height")
                s=$(echo "$monitors" | jq -r ".[$monitor_id].scale")

                cx=$(echo "$x / $s + $w / $s / 2" | bc)
                cy=$(echo "$y / $s + $h / $s / 2" | bc)

                hyprctl dispatch movecursor "$cx" "$cy"
                hyprctl dispatch setfloating address:0x"$window_id"
                hyprctl dispatch resizewindowpixel exact 25% 60%,address:0x"$window_id"
                hyprctl dispatch centerwindow address:0x"$window_id"
            fi
        fi
        ;;
      changefloatingmode*)
        # Extract the window ID from the line
        window_id=$(echo "${1#*>>}" | sed 's/,.*//')

        # Extract the floating state
        floating=$(echo "${1#*>>}" | sed 's/^.*\(.\)/\1/;s/0/false/;s/1/true/')

        if [ "$floating" = "true" ]; then
            monitor_id=$(hyprctl activeworkspace -j | jq '.monitorID')

            # Fetch the list of windows and parse it using jq to find the window by its decimal ID
            window_info=$(hyprctl clients -j | jq --arg id "0x$window_id" ".[] | select(.address == (\$id))")

            # Get size
            monitor_scale=$(hyprctl monitors -j | jq -r ".[$monitor_id].scale")

            # Get current window and monitor size
            window_width=$(echo "$window_info" | jq -r '.size.[0]')
            monitor_width=$(hyprctl monitors -j | jq -r ".[$monitor_id].width")
            max_width=$(echo "scale=0;$monitor_width/$monitor_scale - 20" | bc)

            window_height=$(echo "$window_info" | jq -r ".size.[1]")
            monitor_height=$(hyprctl monitors -j | jq -r ".[$monitor_id].height")
            max_height=$(echo "scale=0;$monitor_height/$monitor_scale - 20" | bc)

            # Decrease window size above threshold
            if [ "$window_width" -ge "$max_width" ] || [ "$window_height" -ge "$max_height" ]; then
                hyprctl dispatch resizeactive -30 -60
                hyprctl dispatch centerwindow
            fi
        fi
        ;;
    esac
}

# Listen to the Hyprland socket for events and process each line with the handle function
socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
