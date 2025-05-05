#!/bin/bash
# Optimize for gaming: NVIDIA GPU, no compositing, high performance

# Kill Picom for max FPS
pkill -f "picom.*--config"

# NVIDIA GPU settings
nvidia-smi -pm 1  # Persistence mode

# TLP settings
sudo tlp ac  # AC profile (performance)
sudo tlp setcharge 0 100 BAT0  # Full charge for gaming
echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Update mode state
echo "gaming" > /tmp/i3_mode_state

notify-send "Gaming Mode" "NVIDIA GPU, no compositing"
