#!/bin/sh

display_current=$(brightnessctl g)
display_maximum=$(brightnessctl m)
display_brightness=$(echo "100*$display_current/$display_maximum" | bc)

keyboard_current=$(brightnessctl g -d smc::kbd_backlight)
keyboard_maximum=$(brightnessctl m -d smc::kbd_backlight)
keyboard_brightness=$(echo "100*$keyboard_current/$keyboard_maximum" | bc)

text="$display_brightness% "
tooltip="Display:  $display_brightness% ($display_current/$display_maximum)\nKeyboard: $keyboard_brightness% ($keyboard_current/$keyboard_maximum)"

# Output JSON for Waybar
echo "{\"text\": \"${text}\", \"tooltip\": \"${tooltip}\"}"

# "format-icons": ["", "", "", "", "", "", "", "", ""],
