#!/bin/bash

# Define the directory where wallpapers are stored
WALLPAPER_DIR="$HOME/.config/i3/walls/"

# Find all image files and pick one randomly
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)

# Set wallpaper using feh
[ -n "$WALLPAPER" ] && feh --bg-scale "$WALLPAPER"

