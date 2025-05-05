#!/bin/sh

battery_print() {
    PATH_AC="/sys/class/power_supply/ACAD"
    PATH_BATTERY="/sys/class/power_supply/BAT1"

    ac=0
    battery_level=0
    battery_max=0

    if [ -f "$PATH_AC/online" ]; then
        ac=$(cat "$PATH_AC/online")
    fi

    if [ -f "$PATH_BATTERY/charge_now" ]; then
        battery_level=$(cat "$PATH_BATTERY/charge_now")
    fi

    if [ -f "$PATH_BATTERY/charge_full" ]; then
        battery_max=$(cat "$PATH_BATTERY/charge_full")
    fi

    # Prevent division by zero
    if [ "$battery_max" -eq 0 ]; then
        echo "Battery info unavailable"
        return
    fi

    battery_percent=$((battery_level * 100 / battery_max))

    if [ "$ac" -eq 1 ]; then
        icon="󰂄"
        [ "$battery_percent" -gt 97 ] && echo "$icon $battery_percent%"
    else
        case $battery_percent in
            9[5-9]|100) icon="" ;;
            9[0-4]|8[5-9]) icon="" ;;
            8[0-4]|7[5-9]) icon="" ;;
            6[0-9]|5[5-9]) icon="" ;;
            3[5-9]|4[0-9]) icon="" ;;
            1[1-9]|2[0-9]) icon="" ;;
            *) icon="" ;;
        esac
        echo "$icon $battery_percent %"
    fi
}

path_pid="/tmp/polybar-battery-udev.pid"

case "$1" in
    --update)
        pid=$(cat "$path_pid" 2>/dev/null || echo "")
        [ -n "$pid" ] && kill -10 "$pid"
        ;;
    *)
        echo $$ > "$path_pid"
        trap exit INT
        trap "echo" USR1

        while true; do
            battery_print
            sleep 30 &
            wait
        done
        ;;
esac
