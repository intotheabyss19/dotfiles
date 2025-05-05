#!/bin/bash
# Prompt user for search query via Rofi
QUERY=$(rofi -dmenu -p "Search: " -theme ~/.config/rofi/rofi-search.rasi)

# Exit if no input
[ -z "$QUERY" ] && exit 0

# URL-encode the query (simple replacement for spaces)
QUERY=$(echo "$QUERY" | sed 's/ /%20/g')

# Open Zen Browser with DuckDuckGo search (or your preferred engine)
zen-browser "https://duckduckgo.com/?q=$QUERY"
