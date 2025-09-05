#!/bin/bash
# ~/.config/yazi/scripts/set_wall.sh

file="$1" 

if [[ -n "$file" && -f "$file" ]]; then
    swww img "$file" --transition-type any --transition-duration 2 --transition-fps 60
else
    notify-send "Yazi → swww" "No valid image selected!"
fi
