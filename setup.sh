#!/bin/bash

set -e

# ---- Variables ----
DOTFILES_REPO="https://github.com/ThePikachuDev/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
SCRIPTS_DIR="$HOME/.scripts"

ESSENTIAL_PACKAGES=(
    base base-devel git zsh neovim tmux kitty rofi waybar
    swww hyprland hyprpaper hyprutils-git grim slurp swappy wl-clipboard
    zathura zathura-pdf-mupdf zathura-gruvbox-git obsidian
    tldr tree fzf bat btop zoxide wget curl
    lua-language-server typescript-language-server jq imagemagick mpv
    vesktop telegram-desktop-bin whatsapp-linux-desktop-bin
    ani-cli ani-skip-git brave-bin firefox google-chrome
    zls-bin zig-bin
    wlogout swaync yad xdg-desktop-portal-gtk xdg-desktop-portal-hyprland
)

AUR_HELPER="yay" # or paru, etc.

# ---- Install Packages ----
echo "[*] Installing essential packages..."
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm "${ESSENTIAL_PACKAGES[@]}"

# ---- Install AUR Packages ----
echo "[*] Installing AUR packages..."
$AUR_HELPER -S --needed --noconfirm github-cli obsidian zls-bin zig-bin vesktop ani-cli ani-skip-git whatsapp-linux-desktop-bin

# ---- Clone Dotfiles ----
echo "[*] Cloning dotfiles..."
git clone "$DOTFILES_REPO" "$DOTFILES_DIR"

# ---- Copy Configs ----
echo "[*] Copying dotfiles configs..."
mkdir -p "$CONFIG_DIR"
cp -r "$DOTFILES_DIR/nvim" "$CONFIG_DIR/"
cp -r "$DOTFILES_DIR/waybar" "$CONFIG_DIR/"
cp -r "$DOTFILES_DIR/i3wm" "$CONFIG_DIR/i3"
cp -r "$DOTFILES_DIR/hypr" "$CONFIG_DIR/"
cp -r "$DOTFILES_DIR/kitty" "$CONFIG_DIR/"
cp "$DOTFILES_DIR/.zshrc" ~/
cp "$DOTFILES_DIR/tmux.conf" ~/.tmux.conf
mkdir -p "$CONFIG_DIR/zathura"
cp "$DOTFILES_DIR/zathurarc" "$CONFIG_DIR/zathura/zathurarc"

# ---- Copy Scripts ----
mkdir -p "$SCRIPTS_DIR"
cp "$DOTFILES_DIR"/nvim-fzf.sh "$SCRIPTS_DIR/"
cp "$DOTFILES_DIR"/tmux-sessionizer.sh "$SCRIPTS_DIR/"
cp "$DOTFILES_DIR"/random_wall.sh "$SCRIPTS_DIR/"
chmod +x "$SCRIPTS_DIR"/*.sh

# ---- Set Default Shell ----
echo "[*] Setting Zsh as default shell..."
chsh -s "$(which zsh)"

# ---- Setup Git SSH ----
# echo "[*] Setting up Git SSH..."
# read -p "Enter your GitHub email: " git_email
# read -p "Enter your GitHub username: " git_user
#
# git config --global user.email "$git_email"
# git config --global user.name "$git_user"
#
# if [ ! -f ~/.ssh/id_ed25519 ]; then
#     echo "[*] Generating SSH key..."
#     ssh-keygen -t ed25519 -C "$git_email"
#     eval "$(ssh-agent -s)"
#     ssh-add ~/.ssh/id_ed25519
#     echo "[*] Your SSH public key (add to GitHub):"
#     cat ~/.ssh/id_ed25519.pub
# fi

# ---- Kitty Font/Theme Reminder ----
echo -e "\n[!] Make sure your kitty.conf includes font and theme settings:"
# echo "  font_family      FiraCode Nerd Font"
# echo "  include theme.conf"

# ---- Done ----
echo -e "\n[✔] Setup complete!"
# echo "👉 Add your SSH key to GitHub: https://github.com/settings/ssh/new"

