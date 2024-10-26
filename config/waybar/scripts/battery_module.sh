#!/bin/sh

# Get battery information
battery_status=$(cat /sys/class/power_supply/BAT0/status)
battery_charge=$(cat /sys/class/power_supply/BAT0/charge_now)
battery_charge_full=$(cat /sys/class/power_supply/BAT0/charge_full)
battery_percent_design=$(cat /sys/class/power_supply/BAT0/capacity)
battery_percent=$(echo "100*$battery_charge/$battery_charge_full" | bc)

# Get current power profile
power_profile=$(powerprofilesctl get)

# Set icon based on battery status and power profile
case $power_profile in
    "performance")
        profile_icon=""
        ;;
    "balanced")
        profile_icon=""
        ;;
    "power-saver")
        profile_icon=""
        ;;
    *)
        profile_icon=""
        ;;
esac

# "     "
# "󰁹󰂀󰁿󰁻󰁺"

# Set battery icon based on percentage and charging status
if [ "$battery_status" = "Charging" ]; then
    battery_icon=" "
elif [ "$battery_status" = "Plugged" ]; then
    battery_icon="🔌"
else
    if [ $battery_percent -ge 80 ]; then
        battery_icon=" "
    elif [ $battery_percent -ge 60 ]; then
        battery_icon=" "
    elif [ $battery_percent -ge 40 ]; then
        battery_icon=" "
    elif [ $battery_percent -ge 20 ]; then
        battery_icon=" "
    else
        battery_icon=" "
    fi
fi

# Construct tooltip with detailed information
text="${profile_icon}  ${battery_percent}% ${battery_icon}"
tooltip="Battery: ${battery_percent}% (Design: $battery_percent_design%)\nStatus:  ${battery_status}\nProfile: ${power_profile}"

# Output JSON for Waybar
echo "{\"text\": \"${text}\", \"tooltip\": \"${tooltip}\", \"class\": \"${power_profile}\"}"
