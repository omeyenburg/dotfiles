#!/bin/sh

if [ "$1" == "point" ]; then
    # Run hyprpicker and copy hex to clipboard
    hex=$(hyprpicker -a --no-zoom)

    # Remove # from hex code
    hex_clean=${hex#\#}

    # Convert hex to RGB values
    r=$((16#${hex_clean:0:2}))
    g=$((16#${hex_clean:2:2}))
    b=$((16#${hex_clean:4:2}))

elif [ "$1" == "select" ]; then
    # Run zenity
    rgb=$(zenity --color-selection | sed 's/^rgb[a]*(//;s/,/ /g;s/)$//')
    echo $rgb

    # Split up components
    r=$(echo $rgb | awk '{ print $1 }')
    g=$(echo $rgb | awk '{ print $2 }')
    b=$(echo $rgb | awk '{ print $3 }')

    # Convert values to hex and prepend missing zeros
    hex_r=$(printf '%x' $r)
    if [ $(echo $hex_r | wc -m) -lt 3 ]; then
        hex_r="0$hex_r"
    fi

    hex_g=$(printf '%x' $g)
    if [ $(echo $hex_g | wc -m) -lt 3 ]; then
        hex_g="0$hex_g"
    fi

    hex_b=$(printf '%x' $b)
    if [ $(echo $hex_b | wc -m) -lt 3 ]; then
        hex_b="0$hex_b"
    fi

    hex="#${hex_r}${hex_g}${hex_b}"
fi

# Convert to RGB percentages (0-1)
r_percent=$(bc -l <<< "$r/255")
g_percent=$(bc -l <<< "$g/255")
b_percent=$(bc -l <<< "$b/255")

# Calculate HSL values (this is a simplified conversion)
max=$(printf "%s\n" $r_percent $g_percent $b_percent | sort -nr | head -n1)
min=$(printf "%s\n" $r_percent $g_percent $b_percent | sort -n | head -n1)
l=$(bc -l <<< "($max + $min)/2")
l_percent=$(bc -l <<< "$l*100")

# Format all values
hex_format="HEX: $hex"
rgb_format="RGB: $r, $g, $b"
rgb_percent="RGB: 0.$((r*10000/255)), 0.$((g*10000/255)), 0.$((b*10000/255))"
hsl_format="HSL: $(printf "%.0f%%" $l_percent) lightness"

# Send notification
~/.config/hypr/scripts/notify.sh "hyprpicker" ""\
    "<span background='$hex'>        </span> $hex_format
<span background='$hex'>        </span> $rgb_format
<span background='$hex'>        </span> $rgb_percent
<span background='$hex'>        </span> $hsl_format" 0
