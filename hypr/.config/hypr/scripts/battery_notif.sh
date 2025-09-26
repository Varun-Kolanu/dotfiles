#!/bin/bash

BATTERY=$(upower -i $(upower -e | grep BAT) | grep percentage | awk '{print $2}' | sed 's/%//')
STATE=$(upower -i $(upower -e | grep BAT) | grep state | awk '{print $2}')

if [ "$STATE" = "discharging" ]; then
    if [ "$BATTERY" -le 5 ]; then
        notify-send -u critical "Battery Critical" "Battery at ${BATTERY}%!"
    elif [ "$BATTERY" -le 20 ]; then
        notify-send -u normal "Battery Low" "Battery at ${BATTERY}%"
    fi
fi