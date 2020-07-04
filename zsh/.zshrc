# Editing
export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER="nvim -R +'set signcolumn=no ft=man' -"

# (Neo)vim
alias ex='nvim -e'
alias vi='nvim'
alias view='nvim -R'
alias vim='nvim'
alias vimdiff='nvim -d'

# ls(exa) aliases
alias ls='exa --git'
alias la='exa --git -la'
alias ll='exa --git -l'

# Prompt
PROMPT=" %F{blue}%c%f %(1j.%F{yellow}*%f .)%(0?..%F{red})%(!.#.$)%f "

# Vi-mode
bindkey -v

# Change cursor shape for different vi modes.
KEYTIMEOUT=1

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

# Completion
autoload -Uz compinit && mkdir -p ~/.cache/zsh && compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_USE_ASYNC=1
bindkey '^f' forward-char
bindkey '^b' backward-char

# Highlighting
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# History
mkdir -p "$XDG_DATA_HOME/zsh"
HISTFILE="$XDG_DATA_HOME/zsh/history"
SAVEHIST=1000
HISTSIZE=1000
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }
source ~/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A'       history-substring-search-up
bindkey '^[[B'       history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
