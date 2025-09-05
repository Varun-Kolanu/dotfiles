#!/bin/bash

# Static wallpaper directory
STATIC_DIR="$HOME/Pictures/Wallpapers"
CACHE_WALL="$HOME/.cache/wallpaper"

# Pick a random static wallpaper recursively
WALL=$(find "$STATIC_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" \) | shuf -n 1)

# Exit if no wallpaper found
if [ -z "$WALL" ]; then
    echo "No wallpapers found in $STATIC_DIR"
    exit 1
fi

# Set wallpaper using swww
swww img "$WALL" --transition-type center --transition-duration 1 --transition-fps 144

# Link to .cache/wallpaper
ln -sf "$WALL" "$CACHE_WALL"
