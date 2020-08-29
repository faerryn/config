# Profile is sourced 
export PERSONAL_PROFILE=

# Reset PATH
[ -n "$PERSONAL_BASE_PATH" ]\
    && export PATH="$PERSONAL_BASE_PATH"\
    || export PERSONAL_BASE_PATH="$PATH"

# XDG directories
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"

# Personal directories
export PERSONAL_CONFIG_HOME="$HOME/config"
export PERSONAL_DATA_HOME="$HOME/local/share"

# Rust
export CARGO_HOME="$PERSONAL_DATA_HOME/cargo"
export RUSTUP_HOME="$PERSONAL_DATA_HOME/rustup"
export PATH="$CARGO_HOME/bin:$PATH"

# Go
export GO_HOME="$HOME/local/go"
export GOPATH="$HOME/go"
export PATH="$GO_HOME/bin:$GOPATH/bin:$PATH"

# PATH
export PATH="$HOME/local/bin:$PATH"

# terminfo
export TERMINFO="$XDG_DATA_HOME/terminfo"
export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"

# less
export LESSHISTFILE="-"

# ccache
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME/ccache/ccache.config"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"

# Wine
export WINEPREFIX="$HOME/wine"

# ls
alias ls="ls -hF --color=auto"

# Neovim
if command -v nvim >/dev/null; then
    export EDITOR="nvim"
    export VISUAL="nvim"
    export MANPAGER="nvim -R +'set ft=man' -"
    alias vim="nvim"
fi
