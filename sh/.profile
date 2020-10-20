# Profile is sourced
export PERSONAL_PROFILE=1

# PATH
if test -n "$PERSONAL_PATH"; then
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

# ccache
export CCACHE_CONFIGPATH="$XDG_CONFIG_HOME/ccache.conf"
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"

# less
export LESSHISTFILE=-

# WINE
export WINEPREFIX="$HOME/wine"
export WINEARCH=win32

case "$-" in
	*i*)
		# Aliases
		alias ls='ls -hvxCFX --color=auto --group-directories-first'
		alias ll='ls -g'
		alias la='ls -gA'

		alias grep='grep --color=auto'

		alias fd='fd --hidden'
		alias rg='rg --hidden'

		if >/dev/null command -v vim; then
			export EDITOR=vim
			export VISUAL=vim
		fi
		;;
esac
