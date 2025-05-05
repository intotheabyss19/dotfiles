#!/usr/bin/env bash

# State file to store toggle status
state_file="/tmp/polybar_time_toggle"

# Initialize state if not exists
if [[ ! -f $state_file ]]; then
    echo "0" > $state_file
fi

# Read current state
a=$(cat $state_file)

toggle() {
    if [[ "$a" -eq 0 ]]; then
        echo "1" > $state_file
    else
        echo "0" > $state_file
    fi
}

if [[ "${BLOCK_BUTTON:-0}" -eq 1 ]]; then
    toggle
    a=$(cat $state_file)  # Refresh state
fi

# Display based on state
if [[ "$a" -eq 0 ]]; then
    date '+%a %d %b %H:%M'
else
    date '+%H:%M'
fi
