#!/bin/sh

# Select wallpaper using Rofi
wallpaper=$(ls $HOME/.config/backgrounds/ | rofi -dmenu -i -p "Select wallpaper:" -font "CaskaydiaCove Nerd Font 11" -config $HOME/.config/rofi/config-wallpaper.rasi)

# If a wallpaper was selected, set it using Hyprpaper
if [ -n "$wallpaper" ]; then
    wallpaper_path="$HOME/.config/backgrounds/$wallpaper"

    echo > ~/.config/feh/feh_wallpaper_changer.sh "#!/bin/sh"
    echo >> ~/.config/feh/feh_wallpaper_changer.sh "feh --bg-fill ~/.config/backgrounds/$wallpaper"

    exec ~/.config/feh/feh_wallpaper_changer.sh

fi
