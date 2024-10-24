#!/bin/sh

# busctl --user call org.freedesktop.Notifications /org/freedesktop/Notifications org.freedesktop.Notifications Notify "susssasa{sv}i" "hyprpicker" 0 "icon-name" "Hex color:" "<span background='$color'>$color</span>" 0 0 5000

color=$(hyprpicker -a)

# Remove # from hex
hex_clean=${color#\#}

# Convert hex to RGB values
r=$((16#${hex_clean:0:2}))
g=$((16#${hex_clean:2:2}))
b=$((16#${hex_clean:4:2}))

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
hex_format="HEX: $color"
rgb_format="RGB: $r, $g, $b"
rgb_percent="RGB: 0.$((r*10000/255)), 0.$((g*10000/255)), 0.$((b*10000/255))"
hsl_format="HSL: $(printf "%.0f%%" $l_percent) lightness"

# Send notification
busctl --user call org.freedesktop.Notifications \
/org/freedesktop/Notifications \
org.freedesktop.Notifications \
Notify "susssasa{sv}i" \
"hyprpicker" 0 "" "" \
"<span background='$color'>        </span> $hex_format
<span background='$color'>        </span> $rgb_format
<span background='$color'>        </span> $rgb_percent
<span background='$color'>        </span> $hsl_format" \
0 0 8000
