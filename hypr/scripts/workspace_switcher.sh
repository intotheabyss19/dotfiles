#!/bin/bash

# Get the list of all active workspaces
active_workspaces=$(hyprctl workspaces -j | jq -r '.[].name')

# Generate options for rofi
options=$(echo -e "$active_workspaces\nNew Workspace")

# Use rofi for selection
selected=$(echo "$options" | rofi -dmenu -i -p "Workspaces:")

hyprctl dispatch workspace "$selected"
