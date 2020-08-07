# Profile is sourced 
export SOURCED_PROFILE=1

# XDG directories
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# PATH
export PATH="$CARGO_HOME/bin:$HOME/.local/bin:$PATH"

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
export CC="ccache cc"
export CXX="ccache c++"

# make
alias make="make -j$(($(nproc) - 1))"

# fzf
export FZF_DEFAULT_COMMAND="fd --hidden"

# wget
alias wget="wget --hsts-file=\"$XDG_CACHE_HOME/wget-hsts\""

# wine
export WINEPREFIX="$HOME/wine"

# ls=exa
if command -v exa >/dev/null; then
    alias ls="exa"
else
    alias ls="ls --color=auto"
fi

# vim and neovim
if command -v nvim >/dev/null; then
    export EDITOR="nvim"
    export VISUAL="nvim"
    export MANPAGER="nvim -R +\"set signcolumn=no ft=man\" -"
elif command -v vim >/dev/null; then
    export EDITOR="vim"
    export VISUAL="vim"
    export MANPAGER="vim -R +\"set signcolumn=no ft=man\" -"
fi
