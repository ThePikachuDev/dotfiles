#!/bin/bash

# Set the directory containing wallpapers
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Get a list of image files
wallpapers=($(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \)))

# Exit if no wallpapers found
if [ ${#wallpapers[@]} -eq 0 ]; then
    echo "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# Pick a random wallpaper
random_wallpaper="${wallpapers[RANDOM % ${#wallpapers[@]}]}"

# Set it using hyprctl
hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$random_wallpaper"
hyprctl hyprpaper wallpaper "eDP-1,$random_wallpaper"   # Change `eDP-1` to your actual monitor name

# Optional: log
echo "Wallpaper set to $random_wallpaper"

