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

    # Split up components
    r=$(echo $rgb | awk '{ print $1 }')
    g=$(echo $rgb | awk '{ print $2 }')
    b=$(echo $rgb | awk '{ print $3 }')

    # Convert values to hex
    hex=$(printf '#%x%x%x\n' $r $g $b)
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
