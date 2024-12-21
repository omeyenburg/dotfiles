#!/bin/sh

if [ "$1" = "point" ]; then
    # Check if hyprpicker is available
    if ! command -v hyprpicker >/dev/null 2>&1; then
        echo "hyprpicker is not installed."
        exit 1
    fi

    # Run hyprpicker and copy hex to clipboard
    hex=$(hyprpicker -a --no-zoom | head -1 | awk '{ print $1 }')

    # Check output
    if [ ! "$hex" ]; then
        echo "Aborting."
        exit 0
    fi

    # Remove # from hex code
    hex_clean=${hex#\#}

    # Convert hex to RGB values
    r=$((0x$(echo "$hex_clean" | cut -c 1,2)))
    g=$((0x$(echo "$hex_clean" | cut -c 3,4)))
    b=$((0x$(echo "$hex_clean" | cut -c 5,6)))
elif [ "$1" = "select" ]; then
    # Check if yad is available
    if ! command -v yad >/dev/null 2>&1; then
        if ! command -v zenity >/dev/null 2>&1; then
            echo "Neither yad nor zenity are installed."
            exit 1
        fi

        # Run zenity as fallback option
        rgb=$(yad --color-selection | sed 's/^rgb[a]*(//;s/,/ /g;s/)$//')

        # Check output
        if [ ! "$rgb" ]; then
            echo "Aborting."
            exit 0
        fi

        # Split up components
        r=$(echo "$rgb" | awk '{ print $1 }')
        g=$(echo "$rgb" | awk '{ print $2 }')
        b=$(echo "$rgb" | awk '{ print $3 }')

        # Convert values to hex and prepend missing zeros
        hex_r=$(printf '%x' "$r")
        if [ $(echo "$hex_r" | wc -m) -lt 3 ]; then
            hex_r="0$hex_r"
        fi

        hex_g=$(printf '%x' 2"$g")
        if [ $(echo "$hex_g" | wc -m) -lt 3 ]; then
            hex_g="0$hex_g"
        fi

        hex_b=$(printf '%x' "$b")
        if [ $(echo "$hex_b" | wc -m) -lt 3 ]; then
            hex_b="0$hex_b"
        fi

        hex="#${hex_r}${hex_g}${hex_b}"
    else
        # Run yad if available
        hex=$(yad --color)

        # Check output
        if [ ! "$hex" ]; then
            echo "Aborting."
            exit 0
        fi

        # Remove # from hex code
        hex_clean=${hex#\#}

        # Convert hex to RGB values
        r=$((0x$(echo "$hex_clean" | cut -c 1,2)))
        g=$((0x$(echo "$hex_clean" | cut -c 3,4)))
        b=$((0x$(echo "$hex_clean" | cut -c 5,6)))
    fi
else
    echo "Please specify an action: point or select"
    exit 0
fi

# Convert to RGB percentages (0-1)
r_percent=$((100 * r / 255))
g_percent=$((100 * g / 255))
b_percent=$((100 * b / 255))

# Calculate HSL values (this is a simplified conversion)
max=$(printf "%s\n" $r_percent $g_percent $b_percent | sort -nr | head -n1)
min=$(printf "%s\n" $r_percent $g_percent $b_percent | sort -n | head -n1)
l_percent=$(((max + min) / 2))

# Format all values
hex_format="HEX: $hex"
rgb_format="RGB: $r, $g, $b"
rgb_percent="RGB: $((r * 100 / 255))%, $((g * 100 / 255))%, $((b * 100 / 255))%"
hsl_format="HSL: $(printf "%.0f%%" $l_percent) lightness"

# Send notification
~/.config/hypr/scripts/notify.sh "hyprpicker" "" \
    "<span background='$hex'>        </span> $hex_format
<span background='$hex'>        </span> $rgb_format
<span background='$hex'>        </span> $rgb_percent
<span background='$hex'>        </span> $hsl_format" 0 >/dev/null

# Send result to command line
echo "$hex"
