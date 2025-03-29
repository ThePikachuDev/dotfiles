#!/bin/bash

WALLPAPER_DIR="$HOME/Code/dotfiles/i3wm/walls/"

WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1 )

feh --bg-scale "$WALLPAPER"
