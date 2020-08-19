# Profile is sourced 
export PERSONAL_PROFILE=

# Reset PATH
if [ -n "$PERSONAL_BASE_PATH" ]; then
    export PATH="$PERSONAL_BASE_PATH"
else
    export PERSONAL_BASE_PATH="$PATH"
fi

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

# Go
export GO_HOME="$HOME/local/go"
export GOPATH="$HOME/go"

# Haskell
export STACK_ROOT="$XDG_DATA_HOME/stack"
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"

# PATH
export PATH="$CARGO_HOME/bin:$GO_HOME/bin:$GOPATH/bin:$HOME/local/bin:$PATH"

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
    if [ -f $1 ]; then
	case $1 in
	    *.tar.bz2)	tar xjf	    $1 ;;
	    *.tar.gz)	tar xzf	    $1 ;;
	    *.bz2)	bunzip	    $1 ;;
	    *.rar)	unrar x	    $1 ;;
	    *.gz)	gunzip	    $1 ;;
	    *.tbz2)	tar xjf	    $1 ;;
	    *.tgz)	tar xzf	    $1 ;;
	    *.zip)	unzip	    $1 ;;
	    *.Z)	uncompress  $1 ;;
	    *.7z)	7z x	    $1 ;;
	    *.deb)	ar x	    $1 ;;
	    *.tar.xz)	tar xf	    $1 ;;
	    *.tar.zst)	unzstd	    $1 ;;
	    *)		echo "'$1' cannot be extracted via ex()" ;;
	esac
    else
	echo "'$1' is not a valid file"
    fi
}
