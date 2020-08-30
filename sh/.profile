# Profile is sourced 
export PERSONAL_PROFILE=

# XDG directories
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_DIRS=/etc/xdg
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS=/usr/local/share:/usr/share

# less
export LESSHISTFILE=-

# Wine
export WINEPREFIX="$HOME/wine"

# ls
alias ls="ls -hvxFX --color=auto --group-directories-first"

# Neovim
if command -v nvim >/dev/null; then
    export EDITOR="nvim"
    export VISUAL="nvim"
    export MANPAGER="nvim -R +'set ft=man' -"
    alias vim="nvim"
fi
