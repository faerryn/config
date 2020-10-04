# Copyright (c) 2020 Jiang Meng Liao (Faerryn) <alexandre.liao@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Ensure that profile is sourced
if [[ -z "$PERSONAL_PROFILE" ]] { source "$HOME/.profile" }

# Empty out precmd_functions and preexec_functions
precmd_functions=()
preexec_functions=()

# zinit
declare -A ZINIT
ZINIT[HOME_DIR]="$XDG_DATA_HOME/zinit"
ZINIT[BIN_DIR]="$ZINIT[HOME_DIR]/bin"
ZINIT[ZCOMPDUMP_PATH]="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
ZINIT[COMPINIT_OPTS]="-d $ZINIT[ZCOMPDUMP_PATH] -C"
export ZPFX="$ZINIT[HOME_DIR]/polaris"

if [[ ! -d "$ZINIT[BIN_DIR]" ]] { git clone --depth 1 https://github.com/zdharma/zinit.git "$ZINIT[BIN_DIR]" }

if [[ -f "$ZINIT[BIN_DIR]/zmodules/Src/zdharma/zplugin.so" ]] {
	module_path+=("$ZINIT[BIN_DIR]/zmodules/Src")
	zmodload zdharma/zplugin
}

source "$ZINIT[BIN_DIR]/zinit.zsh"

zinit ice silent compile
zinit light mafredri/zsh-async

zinit ice silent compile has'git'
zinit light "$XDG_CONFIG_HOME/zsh/smart_prompt"

zinit ice silent compile wait'!0' has'fzf'
zinit light "$XDG_CONFIG_HOME/zsh/smart_fzf"

zinit ice silent compile wait'!0' if'[[ -n "$INSIDE_EMACS" ]]'
zinit light "$XDG_CONFIG_HOME/zsh/emacs_vterm"

zinit ice silent compile wait'!0'
zinit light zsh-users/zsh-completions

zinit ice silent compile wait'!0' has'nix'
zinit light chisui/zsh-nix-shell

zinit ice silent compile wait'!0'
zinit light zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

zinit ice silent compile wait'!0' atinit'zicompinit'
zinit light zsh-users/zsh-syntax-highlighting

# Aliases
alias ls='ls -hvxCFX --color=auto --group-directories-first'
alias ll='ls -g'
alias la='ls -gA'

alias grep='grep --color=auto'

alias fd='fd --hidden'
alias rg="rg --hidden --ignore-file $XDG_CONFIG_HOME/rg/ignore"

# DOOM Emacs
doom () {
	if [ ! -d "$XDG_CONFIG_HOME/emacs/bin" ]; then
		git clone --depth 1 https://github.com/hlissner/doom-emacs.git "$XDG_CONFIG_HOME/emacs"
	fi
	"$XDG_CONFIG_HOME/emacs/bin/doom" "$@"
}

# FEY Neovim
fey () {
	if [ ! -d "$XDG_CONFIG_HOME/nvim/bin" ]; then
		git clone --depth 1 https://github.com/faerryn/fey_neovim.git "$XDG_CONFIG_HOME/nvim"
	fi
	"$XDG_CONFIG_HOME/nvim/bin/fey" "$@"
}

# Navigation
function dc () {
	1="${1:-1}"
	[[ ! "$1" =~ ^[0-9]+$ ]] && return 1
	repeat $1 { cd .. }
}
alias ..=dc

# Bindings
function personal_fg () {
	if [[ -n "$BUFFER" ]] { return }
	fg
	zle reset-prompt
}
zle -N personal_fg
bindkey '^Z' personal_fg

autoload -z edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# History
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY EXTENDED_HISTORY
mkdir -p "$XDG_DATA_HOME/zsh"
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=1000000
SAVEHIST=1000000

# Completion/Correction/Suggestion
setopt CORRECT
zstyle ':completion:*' accept-exact '*(N)'
