#!/bin/sh

function sendwarning() {
    ID_CACHE="$HOME/.cache/waybar_battery_notification"

    # Get last used id
    id=$(cat $ID_CACHE || echo "0")

    # Send notification and save new id
    id=$(~/.config/hypr/scripts/notify.sh "battery-status" "$1" "$battery_percent% remaining. Connect device to a power source." 20000 $2 $id)
    echo "$id" > $ID_CACHE

    # Set power profile to power-saver
    powerprofilesctl set power-saver
}

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
        profile_name="Performance"
        profile_icon=""
        ;;
    "balanced")
        profile_name="Balanced"
        profile_icon=""
        ;;
    "power-saver")
        profile_name="Power Saver"
        profile_icon=""
        ;;
    *)
        profile_name="Unknown"
        profile_icon=""
        ;;
esac

# Set battery icon based on percentage and charging status
if [ "$battery_status" = "Charging" ]; then
    charging_levels=(󰂅 󰂋 󰂊 󰢞 󰂉 󰢝 󰂈 󰂇 󰂆 󰢜 󰢟)
    if [ $battery_percent -ge 95 ]; then
        battery_icon="${charging_levels[0]}"
    elif [ $battery_percent -ge 90 ]; then
        battery_icon="${charging_levels[1]}"
    elif [ $battery_percent -ge 80 ]; then
        battery_icon="${charging_levels[2]}"
    elif [ $battery_percent -ge 70 ]; then
        battery_icon="${charging_levels[3]}"
    elif [ $battery_percent -ge 60 ]; then
        battery_icon="${charging_levels[4]}"
    elif [ $battery_percent -ge 50 ]; then
        battery_icon="${charging_levels[5]}"
    elif [ $battery_percent -ge 40 ]; then
        battery_icon="${charging_levels[6]}"
    elif [ $battery_percent -ge 30 ]; then
        battery_icon="${charging_levels[7]}"
    elif [ $battery_percent -ge 20 ]; then
        battery_icon="${charging_levels[8]}"
    elif [ $battery_percent -ge 10 ]; then
        battery_icon="${charging_levels[9]}"
    else
        battery_icon="${charging_levels[10]}"
    fi
else
    battery_levels=(󰁹 󰂂 󰂁 󰂀 󰁿 󰁾 󰁽 󰁼 󰁻 󰁺 󰂎)
    if [ $battery_percent -ge 95 ]; then
        battery_icon="${battery_levels[0]}"
    elif [ $battery_percent -ge 90 ]; then
        battery_icon="${battery_levels[1]}"
    elif [ $battery_percent -ge 80 ]; then
        battery_icon="${battery_levels[2]}"
    elif [ $battery_percent -ge 70 ]; then
        battery_icon="${battery_levels[3]}"
    elif [ $battery_percent -ge 60 ]; then
        battery_icon="${battery_levels[4]}"
    elif [ $battery_percent -ge 50 ]; then
        battery_icon="${battery_levels[5]}"
    elif [ $battery_percent -ge 40 ]; then
        battery_icon="${battery_levels[6]}"
    elif [ $battery_percent -ge 30 ]; then
        battery_icon="${battery_levels[7]}"
    elif [ $battery_percent -ge 20 ]; then
        battery_icon="${battery_levels[8]}"
    elif [ $battery_percent -ge 10 ]; then
        battery_icon="${battery_levels[9]}"
        sendwarning "Battery status: low" 1
    else
        battery_icon="${battery_levels[10]}"
        sendwarning "Battery status: critical" 2
    fi
fi

# Construct tooltip with detailed information
text="${profile_icon}  ${battery_percent}% ${battery_icon} "
tooltip="Current: ${battery_percent}%\nDesign:  $battery_percent_design%\nStatus:  ${battery_status}\nProfile: ${profile_name}"

# Output JSON for Waybar
echo "{\"text\": \"${text}\", \"tooltip\": \"${tooltip}\", \"class\": \"${power_profile}\"}"
