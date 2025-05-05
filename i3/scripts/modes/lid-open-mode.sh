#!/bin/bash
# Lid Open Mode: Keep processes running normally when lid is closed

# Prompt for sudo password using Rofi
PASSWORD=$(rofi -dmenu -p "Enter password:" -password -theme ~/.config/rofi/rofi-password.rasi)

if [ -z "$PASSWORD" ]; then
    notify-send "Error" "No password entered, aborting"
    exit 1
fi

# Modify systemd logind config to ignore lid close
echo "$PASSWORD" | sudo -S sed -i 's/#HandleLidSwitch=.*/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
echo "$PASSWORD" | sudo -S sed -i 's/#HandleLidSwitchExternalPower=.*/HandleLidSwitchExternalPower=ignore/' /etc/systemd/logind.conf
echo "$PASSWORD" | sudo -S sed -i 's/#HandleLidSwitchDocked=.*/HandleLidSwitchDocked=ignore/' /etc/systemd/logind.conf

# Restart logind to apply changes
echo "$PASSWORD" | sudo -S systemctl restart systemd-logind
if [ $? -ne 0 ]; then
    notify-send "Error" "Incorrect password or systemd-logind failed to restart"
    exit 1
fi

# Update mode state for Polybar
echo "lid_open" > /tmp/i3_mode_state

notify-send "Lid Open Mode" "Processes run normally, lid close ignored"
