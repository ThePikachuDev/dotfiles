# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc
alias zed='$HOME/.var/app/dev.zed.Zed/data/zed'
eval "$(starship init bash)"

# My custom alias
fzf_command() {
  local result=$(fzf)
  if [[ -n "$result" ]]; then
    # You can choose what to do with the selected result here
    nvim $result
  fi
}

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"
alias r="cd ~"
alias pdf="evince"
alias dsa="cd ~/Documents/DSA\ Practice/"
alias cfhypr="nvim ~/.config/hypr/hyprland.conf"
alias cfwaybar="nvim ~/.config/waybar/"
alias cfi="nvim ~/.config/i3/config"
alias cfn="cd ~/.config/nvim/"
alias cpf="nvim ~/Documents/PokeFolio/Portfolio/ "
alias cdot="nvim ~/Documents/dotfiles/"

alias cfbash="nvim ~/.bashrc"
alias wiki="nvim -c VimwikiIndex"

alias notepad="nvim ."


alias allMightyPush="git add . && git commit -m'idc' && git push origin main"


# Player ( MPV )

alias tlauncher="java -jar ~/Downloads/TLauncher.v10/TLauncher.jar"

# Anime Cli Alias
alias anime="ani-cli --dub --skip --no-detach"
alias animc="ani-cli --dub --skip --no-detach -c"

alias yazi="~/yazi/target/release/yazi"
alias ytda='yt-dlp -f bestaudio -o "%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s"'

# Tmux Alias
alias ta="tmux a"
alias tm="tmux"
alias td="tmux kill-session"

# alias yta='ytfzf -L "The text after the command ( yta )" | xargs mpv --volume=60 --no-video'
alias asdf="sudo dnf"
# bun
yta() {
  local query="$*"
  ytfzf -L "$query" | xargs mpv --volume=60 --no-video
}


yal() {
  local query="$*"
  ytfzf -L "$query" | xargs mpv --volume=60 --loop-file --no-video
}

# alias allMightyPush="git add . && git commit -m'idc' && git push origin main"

allMightyPushy() {
    local query="$*"
    git add . && git commit -m"$query" && git push origin main
}




export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH


vmd() {
  pandoc $1 | lynx -stdin
}

. "$HOME/.cargo/env"
