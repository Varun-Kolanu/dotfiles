#!/bin/bash

# hyprctl dispatch exec '[workspace 1 silent] code ~/dotfiles ~/dotfiles/hypr/.config/hypr/hyprland.conf'
hyprctl dispatch exec '[workspace 2 silent] firefox-developer-edition'
hyprctl dispatch exec '[workspace 3 silent] obsidian'
# hyprctl dispatch exec '[workspace 4 silent] spotify'

sleep 2
hyprctl dispatch workspace 2
