# Profile is sourced
export PERSONAL_PROFILE=

# XDG directories
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_DIRS=/etc/xdg
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS=/usr/local/share:/usr/share

# DOOM Emacs
export PATH="$XDG_CONFIG_HOME/emacs/bin:$PATH"

# less
export LESSHISTFILE=-

# Wine
export WINEPREFIX="$HOME/wine"

# ls
alias ls="ls -hvxFX --color=auto --group-directories-first"

# fd
alias fd="fd --ignore-file=$XDG_CONFIG_HOME/fd/ignore"

# Neovim
if {command -v nvim >/dev/null}; then
    export EDITOR="nvim"
    export VISUAL="nvim"
    alias vim="nvim"
fi
