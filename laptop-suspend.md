# Laptop suspend

Here is something that seems to work:
    sudo iwconfig wlp3s0 power off


In hyprland you can set this (https://wiki.hyprland.org/Configuring/Binds/#switches)
here is also more: https://www.reddit.com/r/hyprland/comments/111imsg/hyprland_laptop_closing_lid_turning_to_turn_of/
You can get the switch name with this command: hyprctl devices

# trigger when the switch is toggled
bindl = , switch:[switch name], exec, swaylock
# trigger when the switch is turning on
bindl = , switch:on:[switch name], exec, hyprctl keyword monitor "eDP-1, disable"
# trigger when the switch is turning off
bindl = , switch:off:[switch name], exec, hyprctl keyword monitor "eDP-1, 2560x1600, 0x0, 1"


These are ideas, i have not tested yet and am not sure if it's needed:
1. .
    /etc/NetworkManager/conf.d/

    [connection]
    wifi.powersave = 2

    sudo systemctl restart NetworkManager
2. .
    /etc/systemd/logind.conf

    HandleLidSwitch=ignore
    HandleLidSwitchExternalPower=ignore
    HandleLidSwitchDocked=ignore

    sudo systemctl restart systemd-logind

3. maybe disable ip6
    /etc/sysctl.conf

    net.ipv6.conf.all.disable_ipv6 = 1
    net.ipv6.conf.default.disable_ipv6 = 1


pretty unrelated but nice dotfiles: https://github.com/mylinuxforwork/dotfiles/wiki
