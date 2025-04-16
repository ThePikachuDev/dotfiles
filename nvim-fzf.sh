#!/bin/bash

# -------------------------------
# 🌟 CONFIGURABLE PATHS
# -------------------------------
PATHS=(
    "$HOME/code"
    "$HOME/.config"
    "$HOME/projects"
)

# -------------------------------
# 🧹 EXCLUDES
# -------------------------------
EXCLUDES=(
    ".git"
    "node_modules"
    "target"
    "dist"
    ".venv"
    ".next"
)

# Convert paths to search locations
SEARCH_LOCATIONS=""
for path in "${PATHS[@]}"; do
    [ -d "$path" ] && SEARCH_LOCATIONS="$SEARCH_LOCATIONS $path"
done

# Convert excludes for fd and find
FD_EXCLUDES=""
FIND_EXCLUDES=""
for pattern in "${EXCLUDES[@]}"; do
    FD_EXCLUDES+=" --exclude $pattern"
    FIND_EXCLUDES+=" ! -path \"*/$pattern/*\""
done

# -------------------------------
# 🔍 Run FZF with BAT preview
# -------------------------------
if command -v fd >/dev/null; then
    FILES=$(eval fd . $SEARCH_LOCATIONS --type f $FD_EXCLUDES --hidden | \
        fzf --multi \
            --ansi \
            --preview 'bat --color=always --style=header,grid --line-range=:200 {}' \
            --preview-window=right:60%)
else
    FILES=$(eval find $SEARCH_LOCATIONS -type f $FIND_EXCLUDES 2>/dev/null | \
        fzf --multi \
            --ansi \
            --preview 'bat --color=always --style=header,grid --line-range=:200 {}' \
            --preview-window=right:60%)
fi

# -------------------------------
# 🚪 Exit if nothing selected
# -------------------------------
[ -z "$FILES" ] && echo "No files selected." && exit 0

# -------------------------------
# 🚀 Launch Neovim with all selected files
# -------------------------------
nvim $(echo "$FILES")

