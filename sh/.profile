# Profile is sourced 
export PERSONAL_PROFILE

# XDG directories
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"

# Rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# Go
export GOPATH="$HOME/go"

# Terminfo
export TERMINFO="$XDG_DATA_HOME/terminfo"
export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"

# Go
export GOPATH="$HOME/go"

# PATH
export PATH="$CARGO_HOME/bin:$GOPATH/bin:$XDG_DATA_HOME/go/bin:$HOME/local/bin:$HOME/.local/bin:$PATH"

# systemd
if command -v systemctl >/dev/null; then
    systemctl --user import-environment PATH
fi

# less
export LESSHISTFILE="-"
export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"

# ccache
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME/ccache/ccache.config"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"

# wget
alias wget="wget --hsts-file=\"$XDG_CACHE_HOME/wget-hsts\""

# wine
export WINEPREFIX="$HOME/wine"

# ls
alias ls="ls -hF --color=auto"

# vim and neovim
if command -v nvim >/dev/null; then
    export EDITOR="nvim"
    export VISUAL="nvim"
    export MANPAGER="nvim -R +'set ft=man' -"
    if ! command -v vim >/dev/null; then
	alias vim="nvim"
    fi
elif command -v vim >/dev/null; then
    export EDITOR="vim"
    export VISUAL="vim"
    export MANPAGER="vim -R +MANPAGER -"
fi
