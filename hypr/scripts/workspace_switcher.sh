#!/bin/bash

active_workspaces=$(hyprctl workspaces -j | jq -r '.[].name')

options=$(echo -e "$active_workspaces\nNew Workspace")

selected=$(echo "$options" | rofi -dmenu -i -p "Workspaces:")

hyprctl dispatch workspace "$selected"
