#!/bin/bash
# Battery Mode: Maximize battery life with Intel GPU and minimal compositing, sudo via Rofi

# Ensure TLP and Rofi are installed
if ! command -v tlp >/dev/null || ! systemctl is-active --quiet tlp; then
    notify-send "Error" "TLP not installed or not running"
    exit 1
fi
if ! command -v rofi >/dev/null; then
    notify-send "Error" "Rofi not installed"
    exit 1
fi

notify-send "Enter Password"
# Prompt for sudo password using Rofi
PASSWORD=$(rofi -dmenu -p "Enter password:" -password -theme ~/.config/rofi/rofi-password.rasi)

if [ -z "$PASSWORD" ]; then
    notify-send "Error" "No password entered, aborting"
    exit 1
fi

# Kill existing Picom
pkill -f "picom.*--config"
sleep 0.2  # Ensure clean shutdown


# Switch to Intel GPU and apply TLP battery profile with sudo via password
echo "$PASSWORD" | sudo -S tlp bat
if [ $? -ne 0 ]; then
    notify-send "Error" "Incorrect password or TLP failed"
    exit 1
fi

echo "$PASSWORD" | sudo -S sh -c 'echo "powersave" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'

# Optional: Disable NVIDIA GPU power (requires nvidia-smi)
if command -v nvidia-smi >/dev/null; then
    echo "$PASSWORD" | sudo -S nvidia-smi -pm 0  # Disable persistence mode
fi

# Update mode state for Polybar
echo "battery" > /tmp/i3_mode_state

notify-send "Battery Mode" "Intel GPU, minimal compositing, power saving"
