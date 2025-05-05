#!/usr/bin/bash

state_file="/tmp/feed_state"

# Initialize state if file doesn't exist
if [ ! -f "$state_file" ]; then
    echo "0" > "$state_file"
fi

# Read current state
a=$(cat "$state_file")

if [ "$BLOCK_BUTTON" == "1" ]; then
    if [ "$a" == "0" ]; then
        echo "1" > "$state_file"
        a=1
    else
        echo "0" > "$state_file"
        a=0
    fi
fi

if [ "$a" == "1" ]; then
    echo "  $(curl -sL https://www.lescienze.it/news/ | grep -oE 'href="[^"]+"' | head -n 1 | cut -d'"' -f2)"
else
    echo "󰈙 News"
fi

if [ "$BLOCK_BUTTON" == "3" ]; then
    xdg-open "https://www.lescienze.it/news/"
fi
