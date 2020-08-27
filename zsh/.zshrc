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
alias ....="cd ../../.."

# Prompt
PROMPT=" %F{blue}%3~%f %(1j.%F{yellow}*%f .)%(2L.%F{green}+%f .)%(0?..%F{red})%(!.#.$)%f "
RPROMPT=

function personal_git_prompt () {
    RPROMPT="$(git --no-optional-locks status --branch --porcelain=v2 2>&1 | awk -f $XDG_CONFIG_HOME/zsh/gitprompt.awk)"
}
precmd_functions+=(personal_git_prompt)

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

# Plugins
local PERSONAL_PLUGIN=
for PERSONAL_PLUGIN in "$XDG_CONFIG_HOME/zsh/*/*.plugin.zsh"; do
    source "$PERSONAL_PLUGIN"
done
