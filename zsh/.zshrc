# Ensure that profile is sourced
[[ -z "$PERSONAL_PROFILE" ]] && source "$HOME/.profile"

# Empty out precmd_functions and preexec_functions
precmd_functions=()
preexec_functions=()

# zinit
declare -A ZINIT
ZINIT[BIN_DIR]="$XDG_CONFIG_HOME/zsh/zinit/bin"
ZINIT[HOME_DIR]="$XDG_CONFIG_HOME/zsh/zinit"
ZINIT[ZCOMPDUMP_PATH]="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
ZINIT[COMPINIT_OPTS]="-d $ZINIT[ZCOMPDUMP_PATH] -C"
export ZPFX="$ZINIT[HOME_DIR]/polaris"

[[ ! -d "$ZINIT[BIN_DIR]" ]] && git clone --depth 1 https://github.com/zdharma/zinit.git "$ZINIT[BIN_DIR]"

if [[ -f "$ZINIT[BIN_DIR]/zmodules/Src/zdharma/zplugin.so" ]]; then
    module_path+=("$ZINIT[BIN_DIR]/zmodules/Src")
    zmodload zdharma/zplugin
fi

source "$ZINIT[BIN_DIR]/zinit.zsh"

zinit ice lucid compile wait'!0' atload'precmd_functions+=(personal_prompt)'
zinit load mafredri/zsh-async

zinit ice lucid compile wait'!0'
zinit load kutsan/zsh-system-clipboard

zinit ice lucid as'completion'
zinit snippet https://github.com/tiehuis/zig-compiler-completions/blob/master/completions/_zig

zinit ice lucid compile wait'!0'
zinit load zsh-users/zsh-autosuggestions

zinit ice lucid compile wait'!0' atinit'zicompinit'
zinit load zsh-users/zsh-syntax-highlighting

# Aliases
alias la="ls -A"
alias ll="ls -g"
alias lla="ll -gA"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Manpager
export MANPAGER="vim +'set ft=man'"

# Prompt
PROMPT=" %F{blue}%3~%f %(1j.%F{yellow}*%f .)%(0?..%F{red})%(!.#.$)%f "
RPROMPT=

function personal_prompt_git () {
    2>&1 git -C "$1" --no-optional-locks status --branch --porcelain=v2 | awk -f $XDG_CONFIG_HOME/zsh/gitprompt.awk
}
function personal_prompt_callback () {
    RPROMPT="$3"
    zle reset-prompt
}
function send_prompt_job () {}
function personal_prompt () {
    async_flush_jobs personal_prompt_worker
    while ! {2>/dev/null async_job personal_prompt_worker personal_prompt_git $PWD}; do
	async_start_worker personal_prompt_worker
	async_register_callback personal_prompt_worker personal_prompt_callback
    done
}

# Vi-mode
bindkey -v
bindkey -M viins "^?" backward-delete-char

KEYTIMEOUT=1

function personal_cursor_block () { echo -ne "\e[2 q" }
function personal_cursor_beam () { echo -ne "\e[6 q" }

precmd_functions+=(personal_cursor_beam)
preexec_functions+=(personal_cursor_block)

function zle-keymap-select () {
    if [[ ${KEYMAP} == vicmd ]]; then
	personal_cursor_block
    elif [[ ${KEYMAP} == main ]]; then
	personal_cursor_beam
    fi
}
zle -N zle-keymap-select

# History
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY EXTENDED_HISTORY
mkdir -p "$XDG_DATA_HOME/zsh"
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=1000000
SAVEHIST=1000000

# Completion/Correction/Suggestion
setopt CORRECT
zstyle ':completion:*' accept-exact '*(N)'
ZSH_AUTOSUGGEST_STRATEGY=(completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# fzf
function personal_fzf_file () {
    local WORD="${LBUFFER##* }"
    local PIECES=(${(s:/:)WORD})
    local DIRECTORY="$PRE${(j:/:)PIECES}"
    [[ $WORD[1] = "/" ]] && local PRE="/" || local PRE=
    while [[ ! -d $~DIRECTORY ]] && [[ ${#PIECES[@]} -gt 0 ]]; do
	PIECES=($PIECES[1,-2])
	DIRECTORY="$PRE${(j:/:)PIECES}"
    done
    [[ -n $DIRECTORY ]] && DIRECTORY="$DIRECTORY/"
    local SEARCH="$WORD[${#DIRECTORY}+1,-1]"
    local FILE="$([[ -n $DIRECTORY ]] && cd -q $~DIRECTORY; fd | fzf --height=50% --query="$SEARCH")"
    if [[ -n $FILE ]]; then
	LBUFFER="$LBUFFER[1,-${#WORD}-1]$DIRECTORY$FILE"
    fi
    zle reset-prompt
}
zle -N personal_fzf_file
bindkey "^F" personal_fzf_file

function personal_fzf_history () {
    local LINE="$(fc -lr 0 | sed -r 's/^\s*[0-9]+\*?\s*//' | fzf --height=50% --no-sort --query=$BUFFER)"
    if [[ -n $LINE ]]; then
	LBUFFER="$LINE"
	RBUFFER=
    fi
    zle reset-prompt
}
zle -N personal_fzf_history
bindkey "^R" personal_fzf_history

# emacs-libvterm
if [[ "$INSIDE_EMACS" == vterm ]]; then
    function vterm_printf () { printf "\e]%s\e\\" "$1" }
    function vterm_prompt_end () { vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"; }
    setopt PROMPT_SUBST
    PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'
    function vterm_cmd () {
	local vterm_elisp
	vterm_elisp=""
	while [ $# -gt 0 ]; do
	    vterm_elisp="$vterm_elisp""$(printf '"%s" ' "$(printf "%s" "$1" | sed -e 's|\\|\\\\|g' -e 's|"|\\"|g')")"
	    shift
	done
	vterm_printf "51;E$vterm_elisp"
    }
function emacs () { vterm_cmd find-file "$(realpath "$@")" }
fi
