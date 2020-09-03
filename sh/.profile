# Profile is sourced
export PERSONAL_PROFILE=1

# Path
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
doom () {
    [ ! -d "$XDG_CONFIG_HOME/emacs/bin" ] && git clone --depth 1 https://github.com/hlissner/doom-emacs.git "$XDG_CONFIG_HOME/emacs" 
    "$XDG_CONFIG_HOME/emacs/bin/doom" "$@"
}

# Rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# ccache
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME/ccache.conf"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"

# less
export LESSHISTFILE=-

# Wine
export WINEPREFIX="$HOME/wine"
