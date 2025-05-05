#!/bin/bash

if ! command -v rofi >/dev/null; then
    notify-send "Error" "Rofi not installed"
    exit 1
fi

notify-send "Enter Password"

PASSWORD=$(rofi -dmenu -p "Enter password:" -password -theme ~/.config/rofi/rofi-password.rasi)

if [ -z "$PASSWORD" ]; then
    notify-send "Error" "No password entered, aborting"
    exit 1
fi


echo "$PASSWORD" | sudo -S -E nitrosense
