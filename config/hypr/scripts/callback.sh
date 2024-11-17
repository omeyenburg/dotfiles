#!/bin/sh

# Credit:
# https://github.com/hyprwm/Hyprland/issues/3835

handle() {
    case $1 in
      windowtitle*)
        ## Bitwarden : floating and centered ##

        # Extract the window ID from the line
        window_id=${1#*>>}

        # Fetch the list of windows and parse it using jq to find the window by its decimal ID
        window_info=$(hyprctl clients -j | jq --arg id "0x$window_id" '.[] | select(.address == ($id))')

        # Check if window is floating
        if [[ "$(echo "$window_info" | jq -r '.floating')" == "false" ]]; then

            # Extract the title from the window info
            window_title=$(echo "$window_info" | jq '.title')

            # Check if window is from Bitwarden
            if [[ "$window_title" == *"(Bitwarden Password Manager)"* ]]; then
                # Calculate monitor center
                monitors=$(hyprctl monitors -j)
                x=$(echo $monitors | jq -r '.[].x')
                y=$(echo $monitors | jq -r '.[].y')
                w=$(echo $monitors | jq -r '.[].width')
                h=$(echo $monitors | jq -r '.[].height')
                s=$(echo $monitors | jq -r '.[].scale')
                hyprctl dispatch movecursor $(echo "$x / $s + $w / 2" | bc) $(echo "$y / $s + $h / 2" | bc)

                hyprctl dispatch setfloating address:0x$window_id
                hyprctl dispatch resizewindowpixel exact 20% 50%,address:0x$window_id
                hyprctl dispatch centerwindow address:0x$window_id
            fi
        fi

        ## Firefox opacity : opaque except in new tab page ##
        #
        # if [[ $1 == "windowtitlev2"* ]]; then
        #     # Extract the floating state
        #     title=$(echo "${1#*>>}" | sed 's/^[0-9a-z]*,\(.*\)/\1/')
        #
        #     firefox=$(echo "$title" | sed 's/.*Mozilla Firefox/true/' )
        #     if [ "$firefox" == 'true' ]; then
        #
        #         # Check title
        #         if [ "$title" == 'Mozilla Firefox' ] || [ "$title" == "New Tab — Mozilla Firefox"]; then
        #             hyprctl setprop active opaque false
        #         else
        #             hyprctl setprop active opaque true
        #         fi
        #     fi
        # fi
        ;;
      changefloatingmode*)
        # Extract the window ID from the line
        window_id=$(echo "${1#*>>}" | sed 's/,.*//')

        # Extract the floating state
        floating=$(echo "${1#*>>}" | sed 's/^.*\(.\)/\1/;s/0/false/;s/1/true/')

        if [[ "$floating" == "true" ]]; then

            # Fetch the list of windows and parse it using jq to find the window by its decimal ID
            window_info=$(hyprctl clients -j | jq --arg id "0x$window_id" '.[] | select(.address == ($id))')

            # Get size
            monitor_scale=$(hyprctl monitors -j | jq -r '.[].scale')

            window_width=$(echo $window_info | jq -r '.size.[0]')
            monitor_width=$(hyprctl monitors -j | jq -r '.[].width')
            max_width=$(echo "$monitor_width/$monitor_scale" | bc)

            window_height=$(echo $window_info | jq -r '.size.[1]')
            monitor_height=$(hyprctl monitors -j | jq -r '.[].height')
            max_height=$(echo "$monitor_height/$monitor_scale" | bc)

            if [[ $window_width -ge $max_width ]] || [[ $window_height -ge $max_height ]]; then
                hyprctl dispatch resizeactive -200 -200
                hyprctl dispatch centerwindow
                # hyprctl dispatch moveactive 100 100
            fi
        fi
        ;;
    esac
}

# Listen to the Hyprland socket for events and process each line with the handle function
socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
