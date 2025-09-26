#!/bin/bash
rclone bisync ~/Documents/Hyprland ObsidianSync:Obsidian --conflict-resolve newer
# rclone bisync ~/Documents/Books ObsidianSync:Books --resync ---> for newer syncs
