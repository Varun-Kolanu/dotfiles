#!/bin/bash

# Configuration
DEV="asus::kbd_backlight"
STATE_FILE="/tmp/kbd_backlight_state"
MAX=$(brightnessctl -d "$DEV" max)

# If the state file doesn't exist, assume it's OFF (0)
if [ ! -f "$STATE_FILE" ]; then
    echo 0 > "$STATE_FILE"
fi

CURRENT_STATE=$(cat "$STATE_FILE")

if [ "$CURRENT_STATE" -eq 0 ]; then
    # It was off, so turn it ON
    brightnessctl -d "$DEV" set "$MAX"
    echo "$MAX" > "$STATE_FILE"
else
    # It was on, so turn it OFF
    brightnessctl -d "$DEV" set 0
    echo 0 > "$STATE_FILE"
fi