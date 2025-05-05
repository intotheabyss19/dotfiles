#!/bin/bash
# Toggle Picom off (disables transparency and animations); reload i3 to turn back on

killall picom
# STATE_FILE="/tmp/picom_transparency_state"
#
# # Check current state
# if [ -f "$STATE_FILE" ] && [ "$(cat "$STATE_FILE")" = "on" ]; then
#     # Kill Picom to disable transparency and animations
#     pkill -f "picom.*--config"
#     echo "off" > "$STATE_FILE"
#     echo "transparency_off" > /tmp/i3_mode_state
#     notify-send "Transparency Mode" "Picom disabled (opaque, no animations)"
# else
#     # Do nothing if already off; notify user to reload i3
#     notify-send "Transparency Mode" "Picom already off; reload i3 (Mod+Shift+R) to enable"
# fi
