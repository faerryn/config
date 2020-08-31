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

alias ..="cd .."
alias ...="cd ../.."

# Prompt
setopt PROMPT_SUBST
PROMPT=" %F{blue}%3~%f %(1j.%F{yellow}*%f .)%F{green}%f%(0?..%F{red})%(!.#.$)%f "
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
    if ! {2>/dev/null async_job personal_prompt_worker personal_prompt_git $PWD}; then
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

source "$XDG_CONFIG_HOME/zsh/zsh-system-clipboard/zsh-system-clipboard.zsh"

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
mkdir -p "$XDG_DATA_HOME/zsh"
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=1000000
SAVEHIST=1000000
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY EXTENDED_HISTORY

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
    local SEARCH="$WORD[${#DIRECTORY}+2,-1]"
    local FILE="$([[ -n $DIRECTORY ]] && cd -q $~DIRECTORY; fd -H | fzf --height=50% --query="$SEARCH")"
    if [[ -n $FILE ]]; then
	[[ -n $DIRECTORY ]] && DIRECTORY="$DIRECTORY/"
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

# Completion/Correction
autoload -Uz compinit
mkdir -p "$XDG_CACHE_HOME/zsh"
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
zstyle ':completion:*' accept-exact '*(N)'
setopt CORRECT

# emacs-libvterm
if [[ -n "$INSIDE_EMACS" ]]; then
    function vterm_printf () {
	[ -n "$TMUX" ]\
	    && printf "\ePtmux;\e\e]%s\007\e\\" "$1"\
	    || printf "\e]%s\e\\" "$1"
    }
    function vterm_prompt_end () { vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"; }
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
