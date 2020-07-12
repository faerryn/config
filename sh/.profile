export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export PATH="$HOME/.local/bin:$PATH"

if command -v systemctl >/dev/null; then
	systemctl --user import-environment PATH
fi

export LESSHISTFILE="-"
export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"

export TERMINFO="$XDG_DATA_HOME/terminfo"
export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME/ccache/ccache.config"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"

export WINEPREFIX="$HOME/wine"
if command -v wine >/dev/null; then
	mkdir -p $WINEPREFIX
fi

alias wget="wget --hsts-file=\"$XDG_CACHE_HOME/wget-hsts\""

if command -v nvim >/dev/null; then
	alias ex="nvim -e"
	alias vi="nvim"
	alias view="nvim -R"
	alias vim="nvim"
	alias vimdiff="nvim -d"
	export EDITOR="nvim"
	export VISUAL="nvim"
	export MANPAGER="nvim -R +\"set signcolumn=no ft=man\" -"
fi

export FZF_DEFAULT_COMMAND="fd --hidden --exclude=\"**/.git\" --type=file"

if command -v exa >/dev/null; then
	alias ls="exa"
fi

if command -v bat >/dev/null; then
	alias cat="bat"
fi
