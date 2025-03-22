set -g fish_greeting



if status is-interactive
    starship init fish | source
end

# List Directory
alias l='eza -lh  --icons=auto' # long list
alias lt='eza --icons=auto --tree' # list folder as tree
alias anime="fastanime --dub --icons --preview --fzf anilist"
alias r="cd ~"
alias ..="cd .."
alias wiki="nvim -c VimwikiIndex"
alias notes="nvim ~/vimwiki/notes.wiki"
alias tclock="tty-clock -s -x -c -C 1 -b -t -B"
alias cmanga="cd .local/share/manga-tui/mangaDownloads/"
alias chemistryTable="tptable"

# Handy change dir shortcuts
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .3 'cd ../../..'
abbr .4 'cd ../../../..'
abbr .5 'cd ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
abbr mkdir 'mkdir -p'

krabby random
zoxide init --cmd cd fish | source
