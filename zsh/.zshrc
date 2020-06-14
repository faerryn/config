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
alias v="${EDITOR}"

# ls(exa) aliases
alias l='exa --git'
alias la='exa -la --git'
alias ll='exa -l --git'

# misc aliases
alias g='git'
alias s='sudo'
alias se='sudoedit'

# Prompt
setopt PROMPT_SUBST
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*+set-message:*' hooks git-extras

function +vi-git-extras() {
	if [[ -n $(git ls-files --exclude-standard --others 2> /dev/null) ]]; then
		hook_com[unstaged]+="%F{yellow}•%f"
	fi
	if [[ -n `git remote` ]]; then
		if [[ `git rev-list @{u}..HEAD --count` > 0 ]]; then
			hook_com[misc]+="%F{green}↑%f"
		fi
		if [[ `git rev-list HEAD..@{u} --count` > 0 ]]; then
			hook_com[misc]+="%F{red}↓%f"
		fi
	fi
}

function precmd() { vcs_info }

zstyle ':vcs_info:*' stagedstr '%F{green}•%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}•%f'
zstyle ':vcs_info:*' formats '%m%c%u%F{magenta}%r%f(%F{blue}%b%f)'
zstyle ':vcs_info:*' actionformats '%m%F{green}%c%f%F{red}%u%F{yellow}%a-%F{magenta}%r%f(%F{blue}%b%f)'

PROMPT=" %F{blue}%c%f %(1j.%F{yellow}*%f .)%(0?..%F{red}%? )%(!.#.$)%f "
RPROMPT="\${vcs_info_msg_0_}"

# Change cursor shape for different vi modes.
export KEYTIMEOUT=1

zle -N zle-keymap-select
function zle-keymap-select() {
	if [[ ${KEYMAP} = vicmd ]] || [[ $1 = 'block' ]]; then
		echo -ne '\e[1 q'
	elif [[ ${KEYMAP} = main ]] || [[ ${KEYMAP} = viins ]] || [[ -z ${KEYMAP} ]] || [[ $1 = 'beam' ]]; then
		echo -ne '\e[5 q'
	fi
}

zle -N zle-line-init
function zle-line-init() { echo -ne "\e[5 q" }

echo -ne "\e[5 q"

# Edit line in vim with alt-e:
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# fzf
export FZF_ALT_C_COMMAND="fd -HL -E '**/.git/' -td . \$dir"
export FZF_CTRL_T_COMMAND="fd -HL -E '**/.git/' -tf . \$dir"
export FZF_DEFAULT_COMMAND="fd -HL -E '**/.git/' -tf"
if [[ -f ~/.fzf.zsh ]]; then
	source ~/.fzf.zsh
elif [[ -d /usr/share/fzf ]]; then
	source /usr/share/fzf/completion.zsh
	source /usr/share/fzf/key-bindings.zsh
fi
