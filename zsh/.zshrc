# Ensure that profile is sourced
[[ -v $PERSONAL_PROFILE ]] || source "$HOME/.profile"

# Empty out precmd_functions and preexec_functions
precmd_functions=()
preexec_functions=()

# Globbing
setopt EXTENDED_GLOB

# Aliases
alias la="ls -A"
alias ll="ls -g"
alias lla="ll -gA"

alias ec="emacsclient"
alias em="emacs"

alias ..="cd .."
alias ...="cd ../.."

# Prompt
PROMPT=" %F{blue}%3~%f %(1j.%F{yellow}*%f .)"
if [ $SHLVL -gt 1 ]; then
    PROMPT+="%F{green}"
    repeat $SHLVL-1 { PROMPT+="+" }
    PROMPT+="%f "
fi
PROMPT+="%(0?..%F{red})%(!.#.$)%f "
RPROMPT=

source "$XDG_CONFIG_HOME/zsh/zsh-async/async.zsh"
async_init

function personal_prompt_git () {
    2>&1 git -C "$1" --no-optional-locks status --branch --porcelain=v2 | awk -f $XDG_CONFIG_HOME/zsh/gitprompt.awk
}
function personal_prompt_callback () {
    RPROMPT="$3"
    zle reset-prompt
}
function personal_prompt () {
    async_flush_jobs personal_prompt_worker
    if ! 2>/dev/null async_job personal_prompt_worker personal_prompt_git $PWD; then
	personal_prompt_worker_init
	async_flush_jobs personal_prompt_worker
    fi
}
function personal_prompt_worker_init () {
    async_start_worker personal_prompt_worker
    async_register_callback personal_prompt_worker personal_prompt_callback
}
personal_prompt_worker_init

precmd_functions+=(personal_prompt)

# Vi-mode
bindkey -v
bindkey -M viins "^?" backward-delete-char

KEYTIMEOUT=1

function personal_cursor_block () { echo -ne "\e[2 q" }
function personal_cursor_beam () { echo -ne "\e[6 q" }

function zle-line-init () { personal_cursor_beam }
zle -N zle-line-init

function zle-keymap-select () {
    if [[ ${KEYMAP} == vicmd ]]; then
	personal_cursor_block
    elif [[ ${KEYMAP} == main ]]; then
	personal_cursor_beam
    fi
}
zle -N zle-keymap-select
precmd_functions+=(personal_cursor_beam)
preexec_functions+=(personal_cursor_block)
personal_cursor_beam

# History
mkdir -p "$XDG_DATA_HOME/zsh"
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=1000000
SAVEHIST=1000000
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY EXTENDED_HISTORY

# fzf
function personal_fzf_file () {
    local WORD="${LBUFFER##* }"
    local DIRECTORY="$WORD"
    local DIRECTORY_LEN=${#DIRECTORY}
    local STUB=
    local FILE=
    while [[ ! -d $~DIRECTORY ]] && [[ -n "$DIRECTORY" ]]; do
	DIRECTORY="${DIRECTORY%/*}"
	[[ ${#DIRECTORY} -eq $DIRECTORY_LEN ]] && DIRECTORY=
	DIRECTORY_LEN=${#DIRECTORY}
    done
    if [[ -n "$DIRECTORY" ]]; then
	pushd -q $~DIRECTORY
	STUB="$WORD[$DIRECTORY_LEN+2,-1]"
    else
	STUB="$WORD[$DIRECTORY_LEN+1,-1]"
    fi
    FILE="$(fd -H | fzf --border=rounded --height=50% --query=$STUB)"
    [[ -n "$FILE" ]] && LBUFFER="$LBUFFER[1,-$((${#WORD}+1))]$DIRECTORY$FILE"
    [[ -n "$DIRECTORY" ]] && popd -q
    zle reset-prompt
}
zle -N personal_fzf_file
bindkey "^F" personal_fzf_file

function personal_fzf_history () {
    local LINE="$(fc -lr 0 | sed -r 's/^\s*[0-9]+\*?\s*//' | fzf --border=rounded --height=50% --no-sort --query=$BUFFER)"
    if [[ -n $LINE ]]; then
	LBUFFER="$LINE"
	RBUFFER=
    fi
    zle reset-prompt
}
zle -N personal_fzf_history
bindkey '^R' personal_fzf_history

# Completion/Correction
autoload -Uz compinit
mkdir -p "$XDG_CACHE_HOME/zsh"
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
zstyle ':completion:*' accept-exact '*(N)'
setopt CORRECT
