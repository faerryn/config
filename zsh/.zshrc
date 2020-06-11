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
setopt PROMPT_SUBST

# Prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%b' '%c%u'
precmd() {

	local VCS_INFO=""
	vcs_info
	if [[ -n ${vcs_info_msg_0_} ]]; then
		if [[ -n ${vcs_info_msg_1_} ]]; then
			VCS_INFO="(%F{red}"
		else
			VCS_INFO="(%F{green}"
		fi
		VCS_INFO="${VCS_INFO}${vcs_info_msg_0_}%f)"
	fi

	PROMPT="[%F{yellow}%c%f]${VCS_INFO}%(!.#.$) "
	RPROMPT="%(0?..%F{red}%?%f)"
}

# Change cursor shape for different vi modes.
export KEYTIMEOUT=1
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne
preexec() { echo -ne '\e[5 q' ;}

# Editing
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim -c 'set ft=man' -"

# Aliases
alias g="git"
alias l="exa"
alias la="exa -la"
alias ll="exa -l"
alias s="sudo"
alias se="sudoedit"
alias v="nvim"

# fzf
for FZF_ZSH_DIR in "/usr/share/fzf" "$HOME/.fzf/shell"; do
	if [ -d "$FZF_ZSH_DIR" ]; then
		. "$FZF_ZSH_DIR/completion.zsh"
		. "$FZF_ZSH_DIR/key-bindings.zsh"
		break
	fi
done
FD_FLAGS="-HL -E '**/.git/'"
export FZF_ALT_C_COMMAND="fd $FD_FLAGS -td . \$dir"
export FZF_CTRL_T_COMMAND="fd $FD_FLAGS -tf . \$dir"
export FZF_DEFAULT_COMMAND="fd $FD_FLAGS -tf"
