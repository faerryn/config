export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export PATH="$HOME/.local/bin:$PATH"

export LESSHISTFILE="-"
export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"

export TERMINFO="$XDG_DATA_HOME/terminfo"
export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

if command -v ccache >/dev/null; then
	export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME/ccache/ccache.config"
	export CCACHE_DIR="$XDG_CACHE_HOME/ccache"
fi

if command -v gpg >/dev/null; then
	export GNUPGHOME="$XDG_DATA_HOME/gnupg"
	mkdir -p $GNUPGHOME
fi

if command -v wine >/dev/null; then
	export WINEPREFIX="$HOME/Wine"
	mkdir -p $WINEPREFIX
fi

if command -v wget >/dev/null; then
	alias wget="wget --hsts-file=\"$XDG_CACHE_HOME/wget-hsts\""
fi
