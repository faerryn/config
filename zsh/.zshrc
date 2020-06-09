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
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt PROMPT_SUBST

# VCS
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats '(%b)'

# Prompt
PROMPT="[%F{green}%c%f]\$vcs_info_msg_0_%(!.#.$) "
RPROMPT="%(0?..%F{red}%?%f)"

# Editing
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim -c 'set ft=man' -"

# fzf
for FZF_ZSH_DIR in "/usr/share/fzf" "$HOME/.fzf/shell"; do
	if [ -d "$FZF_ZSH_DIR" ]; then
		. "$FZF_ZSH_DIR/completion.zsh"
		. "$FZF_ZSH_DIR/key-bindings.zsh"
		break
	fi
done

# Aliases
alias g="git"
alias l="exa"
alias la="exa -la"
alias ll="exa -l"
alias s="sudo"
alias se="sudoedit"
alias v="nvim"

# Fast and useful fzf
FD_FLAGS="-HL -E '**/.git/'"
export FZF_ALT_C_COMMAND="fd $FD_FLAGS -td . \$dir"
export FZF_CTRL_T_COMMAND="fd $FD_FLAGS -tf . \$dir"
export FZF_DEFAULT_COMMAND="fd $FD_FLAGS -tf"

# Nicer ls/exa output
[ -e "$XDG_CONFIG_HOME/dircolors/dir_colors" ]\
	&& eval `dircolors "$XDG_CONFIG_HOME/dircolors/dir_colors"`
