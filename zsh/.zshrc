# Lines configured by zsh-newuser-install
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
# End of lines added by compinstall

# Zsh options
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY
setopt EXTENDED_GLOB

# Editing
export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER="view +'set signcolumn=no ft=man' -"
alias v="$EDITOR"

# ls(exa) aliases
alias l='exa --git'
alias la='exa -la --git'
alias ll='exa -l --git'

# misc aliases
alias g='git'
alias s='sudo'
alias se='sudoedit'
alias t='tmux'

function n() {
	# Block nesting of nnn in subshells
	if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
		echo "nnn is already running"
		return
	fi
	export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
	nnn -e "$@"
	if [ -f "$NNN_TMPFILE" ]; then
		. "$NNN_TMPFILE"
		rm -f "$NNN_TMPFILE" > /dev/null
	fi
}

# Prompt
PROMPT=" %F{blue}%c%f %(1j.%F{yellow}*%f .)%(0?..%F{red}%? )%(!.#.$)%f "

# Change cursor shape for different vi modes.
export KEYTIMEOUT=1

zle -N zle-keymap-select
function zle-keymap-select() {
	if [[ $KEYMAP = vicmd ]] || [[ $1 = 'block' ]]; then
		echo -ne '\e[1 q'
	elif [[ $KEYMAP = main ]] || [[ $KEYMAP = viins ]] || [[ -z $KEYMAP ]] || [[ $1 = 'beam' ]]; then
		echo -ne '\e[5 q'
	fi
}

zle -N zle-line-init
function zle-line-init() { echo -ne '\e[5 q' }

echo -ne '\e[5 q'

# fzf
export FZF_ALT_C_COMMAND="fd -HL -E '**/.git/' -td . \$dir"
export FZF_CTRL_T_COMMAND="fd -HL -E '**/.git/' -tf . \$dir"
export FZF_DEFAULT_COMMAND="fd -HL -E '**/.git/' -tf"

if [[ -d ~/.local/lib/fzf ]]; then
	source ~/.local/lib/fzf/shell/completion.zsh
	source ~/.local/lib/fzf/shell/key-bindings.zsh
elif [[ -d /usr/share/fzf ]]; then
	source /usr/share/fzf/completion.zsh
	source /usr/share/fzf/key-bindings.zsh
fi
