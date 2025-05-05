#!/bin/sh

# Select wallpaper using Rofi
wallpaper=$(ls $HOME/.config/backgrounds/ | rofi -dmenu -i -p "Select wallpaper:" -font "CaskaydiaCove Nerd Font 11" -config $HOME/.config/rofi/config-wallpaper.rasi)

# If a wallpaper was selected, set it using Hyprpaper
if [ -n "$wallpaper" ]; then
    wallpaper_path="$HOME/.config/backgrounds/$wallpaper"

    # Preload and set wallpaper for all monitors
    hyprctl hyprpaper preload "$wallpaper_path"

    # Get the list of active displays and set the wallpaper on each
    for monitor in $(hyprctl monitors | grep "Monitor" | awk '{print $2}' | tr -d ':'); do
        # Apply the wallpaper
        hyprctl hyprpaper wallpaper "$monitor,$wallpaper_path"
        # Rewrite the hyprpaper.conf file with the new wallpaper
        echo > ~/.config/hypr/hyprpaper.conf "preload = ~/.config/backgrounds/$wallpaper"
        echo >> ~/.config/hypr/hyprpaper.conf "wallpaper =, ~/.config/backgrounds/$wallpaper"
    done
fi
