# Profile is sourced
export PERSONAL_PROFILE=1

# PATH
if [ -n "$PERSONAL_PATH" ]; then
	export PATH="$PERSONAL_PATH"
else
	export PERSONAL_PATH="$PATH"
fi

# XDG directories
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME/.cache"}"
export XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS:-/etc/xdg}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"

# local bin
export PATH="$HOME/.local/bin:$PATH"

# DOOM Emacs
doom () {
	if [ ! -d "$XDG_CONFIG_HOME/emacs/bin" ]; then
		git clone --depth 1 https://github.com/hlissner/doom-emacs.git "$XDG_CONFIG_HOME/emacs"
	fi
	"$XDG_CONFIG_HOME/emacs/bin/doom" "$@"
}

# FEY Neovim
fey () {
	if [ ! -d "$XDG_CONFIG_HOME/nvim/bin" ]; then
		git clone --depth 1 https://github.com/faerryn/fey_neovim.git "$XDG_CONFIG_HOME/nvim"
	fi
	"$XDG_CONFIG_HOME/nvim/bin/fey" "$@"
}

# MANPAGER
if >/dev/null command -v vim; then
	export MANPAGER='vim +"set ft=man"'
fi

# rust
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export PATH="$CARGO_HOME/bin:$PATH"

# go
export GOPATH="$XDG_DATA_HOME/go"

# ccache
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME/ccache.conf"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"

# less
export LESSHISTFILE=-

# WINE
export WINEPREFIX="$HOME/wine"
