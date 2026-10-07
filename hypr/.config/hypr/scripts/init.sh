#!/bin/bash

hyprctl dispatch 'hl.dsp.exec_cmd("firefox-developer-edition", { workspace = "1 silent" })'

# hyprctl dispatch 'hl.dsp.exec_cmd("code ~/dotfiles ~/dotfiles/hypr/.config/hypr/hyprland.lua", { workspace = "2 silent" })'
# hyprctl dispatch 'hl.dsp.exec_cmd("obsidian", { workspace = "3 silent" })'
# hyprctl dispatch 'hl.dsp.exec_cmd("spotify", { workspace = "4 silent" })'

sleep 2

hyprctl dispatch 'hl.dsp.focus({ workspace = "1" })'