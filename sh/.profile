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

# Extract
extract () {
    if [ ! -f $1 ]; then
	echo "'$1' is not a valid file" >&2
	return 1
    fi
    case $1 in
	*.tar.bz2)  tar xjf	$1 ;;
	*.tar.gz)   tar xzf	$1 ;;
	*.bz2)	    bunzip	$1 ;;
	*.rar)	    unrar x	$1 ;;
	*.gz)	    gunzip	$1 ;;
	*.tbz2)	    tar xjf	$1 ;;
	*.tgz)	    tar xzf	$1 ;;
	*.zip)	    unzip	$1 ;;
	*.Z)	    uncompress	$1 ;;
	*.7z)	    7z x	$1 ;;
	*.deb)	    ar x	$1 ;;
	*.tar.xz)   tar xf	$1 ;;
	*.tar.zst)  unzstd	$1 ;;
	*)  echo "'$1' cannot be extracted" >&2
	    return 1 ;;
    esac
}
