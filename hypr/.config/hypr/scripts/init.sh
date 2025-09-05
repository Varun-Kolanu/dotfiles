#!/bin/bash

hyprctl dispatch exec '[workspace 1 silent] code ~/dotfiles ~/dotfiles/hypr/.config/hypr/hyprland.conf'
hyprctl dispatch exec '[workspace 2 silent] zen-browser'
hyprctl dispatch exec '[workspace 3 silent] wezterm'
# hyprctl dispatch exec '[workspace 4 silent] spotify'

sleep 2
hyprctl dispatch workspace 3