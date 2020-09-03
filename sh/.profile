# Profile is sourced
export PERSONAL_PROFILE=1

# Path is reset
[ -z "$PERSONAL_PATH" ]\
    && export PERSONAL_PATH="$PATH"\
    || export PATH="$PERSONAL_PATH"

# XDG directories
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_DIRS=/etc/xdg
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS=/usr/local/share:/usr/share

# DOOM Emacs
export PATH="$XDG_CONFIG_HOME/emacs/bin:$PATH"

# ls
alias ls="ls -hvxFX --color=auto --group-directories-first"

# fd
alias fd="fd --hidden --ignore-file=$XDG_CONFIG_HOME/fd/ignore"

# rg
alias rg="rg --hidden"

# Rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# ccache
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME/ccache.conf"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"

# less
export LESSHISTFILE=-

# Wine
export WINEPREFIX="$HOME/wine"
