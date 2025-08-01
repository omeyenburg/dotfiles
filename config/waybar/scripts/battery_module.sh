#!/usr/bin/env bash

# Positional arguments:
# title
# type (normal=0, warning=1, critical=2)
send_battery_warning() {
    id_cache="/tmp/battery-notification-id"

    # Get last used id
    id=$(cat "$id_cache" || echo "0")

    if [ "$battery_percent" -ge 90 ]; then
        message="$battery_percent% remaining."
    else
        message="$battery_percent% remaining. Connect device to a power source."
    fi

    # Send notification and save new id
    id=$(~/.local/bin/dot-notify "battery-status" "$1" "$message" 20000 "$2" "$id")
    echo "$id" > "$id_cache"

    # Set power profile to power-saver
    powerprofilesctl set power-saver
}

# # Get battery information
battery_data=$(acpi | head -1 | sed "s/.*: //;s/[,%]//g;")
battery_status=$(echo "$battery_data" | awk '{ print $1 }')
battery_percent=$(echo "$battery_data" | awk '{ print $2 }')
battery_remaining=$(echo "$battery_data" | awk '{ print $3 }')

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
        profile_icon="?"
        ;;
esac

# Set battery icon based on percentage and charging status
# Full, Charging, Discharging
if [ "$battery_status" = "Charging" ]; then
    color_status="charging"
    charging_levels=(󰂅 󰂋 󰂊 󰢞 󰂉 󰢝 󰂈 󰂇 󰂆 󰢜 󰢟)
    if [ "$battery_percent" -ge 95 ]; then
        battery_icon="${charging_levels[0]}"
        send_battery_warning "Battery fully charged" 1
    elif [ "$battery_percent" -ge 90 ]; then
        battery_icon="${charging_levels[1]}"
    elif [ "$battery_percent" -ge 80 ]; then
        battery_icon="${charging_levels[2]}"
    elif [ "$battery_percent" -ge 70 ]; then
        battery_icon="${charging_levels[3]}"
    elif [ "$battery_percent" -ge 60 ]; then
        battery_icon="${charging_levels[4]}"
    elif [ "$battery_percent" -ge 50 ]; then
        battery_icon="${charging_levels[5]}"
    elif [ "$battery_percent" -ge 40 ]; then
        battery_icon="${charging_levels[6]}"
    elif [ "$battery_percent" -ge 30 ]; then
        battery_icon="${charging_levels[7]}"
    elif [ "$battery_percent" -ge 20 ]; then
        battery_icon="${charging_levels[8]}"
    elif [ "$battery_percent" -ge 10 ]; then
        battery_icon="${charging_levels[9]}"
    else
        color_status="warning"
        battery_icon="${charging_levels[10]}"
    fi
else
    battery_levels=(󰁹 󰂂 󰂁 󰂀 󰁿 󰁾 󰁽 󰁼 󰁻 󰁺 󰂎)
    if [ "$battery_percent" -ge 95 ]; then
        battery_icon="${battery_levels[0]}"
    elif [ "$battery_percent" -ge 90 ]; then
        battery_icon="${battery_levels[1]}"
    elif [ "$battery_percent" -ge 80 ]; then
        battery_icon="${battery_levels[2]}"
    elif [ "$battery_percent" -ge 70 ]; then
        battery_icon="${battery_levels[3]}"
    elif [ "$battery_percent" -ge 60 ]; then
        battery_icon="${battery_levels[4]}"
    elif [ "$battery_percent" -ge 50 ]; then
        battery_icon="${battery_levels[5]}"
    elif [ "$battery_percent" -ge 40 ]; then
        battery_icon="${battery_levels[6]}"
    elif [ "$battery_percent" -ge 30 ]; then
        battery_icon="${battery_levels[7]}"
    elif [ "$battery_percent" -ge 20 ]; then
        battery_icon="${battery_levels[8]}"
    elif [ "$battery_percent" -ge 10 ]; then
        battery_icon="${battery_levels[9]}"
        color_status="warning"
        send_battery_warning "Battery status: low" 1
    else
        battery_icon="${battery_levels[10]}"
        color_status="critical"
        send_battery_warning "Battery status: critical" 2
    fi
fi


# Construct tooltip with detailed information
if [ "$profile_name" = "Unknown" ]; then
    tooltip="Current:   ${battery_percent}%\nRemaining: $battery_remaining\nStatus:    ${battery_status}"
    text=" ${battery_percent}% ${battery_icon} "
else
    tooltip="Current:   ${battery_percent}%\nRemaining: $battery_remaining\nStatus:    ${battery_status}\nProfile:   ${profile_name}"
    text="${profile_icon}  ${battery_percent}% ${battery_icon} "
fi

# Output JSON for Waybar
echo "{\"text\": \"${text}\", \"tooltip\": \"${tooltip}\", \"class\": \"${color_status}\"}"
