#!/bin/bash

# Get current animation state (integer value)
HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk '/int:/ {print $2}')

# Debugging: Print the value
echo "HYPRGAMEMODE is: '$HYPRGAMEMODE'"

if [ "$HYPRGAMEMODE" = "1" ]; then
    hyprctl --batch "
        keyword animations:enabled 0;
        keyword general:col.active_border rgba(0000);
        keyword decoration:drop_shadow 0;
        keyword decoration:blur:enabled 0;
        keyword general:gaps_in 0;
        keyword general:gaps_out 0;
        keyword general:border_size 0;
        keyword decoration:active_opacity 1.0;
        keyword decoration:inactive_opacity 1.0;
        keyword decoration:rounding 0;
        keyword decoration:shadow {enabled=false};
        keyword decoration:blur {enabled=false};
    "
    exit
fi

hyprctl reload
