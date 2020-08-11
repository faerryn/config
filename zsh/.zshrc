function () {
    # Ensure that profile is sourced
    if [[ ! -v $PERSONAL_PROFILE ]]; then
	source "$HOME/.profile"
    fi

    # Plugins
    local PLUGIN
    for PLUGIN in $XDG_CONFIG_HOME/zsh/*/*.plugin.zsh; do
	source $PLUGIN
    done

    # Aliases
    alias la="ls -A"
    alias ll="ls -l"
    alias lla="ll -lA"

    alias ec="emacsclient"
    alias em="emacs"

    alias ..="cd .."
    alias ...="cd ../.."
    alias ....="cd ../../.."

    # Prompt
    PROMPT=" [ %F{blue}%3~%f %(1j.%F{yellow}*%f .)%(2L.%F{green}+%f .)%(0?..%F{red})%(!.#.$)%f ] "
    RPROMPT=

    async_init

    function personal-git-prompt () {
	cd -q $1
	git --no-optional-locks status --branch --porcelain=v2 2>&1 | awk -f $XDG_CONFIG_HOME/zsh/gitprompt.awk
    }
    function personal-prompt-callback () {
	RPROMPT=$3
	zle reset-prompt
	async_job "personal-prompt-worker" personal-git-prompt $PWD
    }

    async_start_worker "personal-prompt-worker" -n
    async_register_callback "personal-prompt-worker" personal-prompt-callback
    async_job "personal-prompt-worker" personal-git-prompt $PWD

    # Vi-mode
    bindkey -v
    bindkey -M viins "^?" backward-delete-char

    KEYTIMEOUT=1

    local function personal-cursor-block () { echo -ne "\e[2 q" }
    local function personal-cursor-beam () { echo -ne "\e[6 q" }

    function zle-line-init () { personal-cursor-beam }
    zle -N zle-line-init

    function zle-keymap-select () {
	if [[ ${KEYMAP} == vicmd ]]; then
	    personal-cursor-block
	elif [[ ${KEYMAP} == main ]]; then
	    personal-cursor-beam
	fi
    }

    zle -N zle-keymap-select

    precmd_functions+=(personal-cursor-beam)
    preexec_functions+=(personal-cursor-block)
    personal-cursor-beam

    # History
    mkdir -p "$XDG_DATA_HOME/zsh"
    HISTFILE="$XDG_DATA_HOME/zsh/history"
    HISTSIZE=1000000
    SAVEHIST=1000000
    setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY EXTENDED_HISTORY

    # Completion/Correction
    autoload -Uz compinit
    mkdir -p "$HOME/.cache/zsh"
    compinit -d "$HOME/.cache/zsh/zcompdump-$ZSH_VERSION"
    setopt CORRECT

    # FZF
    if [[ ! -a "$XDG_CONFIG_HOME/zsh/fzf/bin/fzf" ]]; then
	"$XDG_CONFIG_HOME/zsh/fzf/install" --bin
    fi
    if ! command -v fzf >/dev/null; then
	export PATH="$XDG_CONFIG_HOME/zsh/fzf/bin:$PATH"
    fi

    function personal-fzf-file () {
	local WORD="${LBUFFER##* }"
	local DIRECTORY="$WORD"
	while [[ -n $DIRECTORY ]] && [[ ! -d $DIRECTORY ]]; do
	    DIRECTORY="${DIRECTORY%/*}"
	done
	local STUB="$WORD[$((${#DIRECTORY}+2)),-1]"
	local FILE="$(fd -Htf . $~DIRECTORY | fzf --border=rounded --height=50% --query=$STUB)"
	if [[ -a $FILE ]]; then
	    LBUFFER="$LBUFFER[1,-$((${#WORD}+1))]$FILE"
	fi
	zle reset-prompt
    }
    zle -N personal-fzf-file
    bindkey "^f" personal-fzf-file

    function personal-fzf-directory () {
	local DIRECTORY="$(fd -Htd -d1 | fzf --border=rounded --height=50%)"
	if [[ -d $DIRECTORY ]]; then
	    cd "$DIRECTORY"
	fi
	zle reset-prompt
    }
    zle -N personal-fzf-directory
    bindkey "\ec" personal-fzf-directory

    function personal-fzf-history () {
	local LINE="$(fc -lr 0 | sed -r 's/^\s*[0-9]+\*?\s*//' | fzf --border=rounded --height=50% --no-sort --query=$BUFFER)"
	if [[ -n $LINE ]]; then
	    LBUFFER="$LINE"
	    RBUFFER=
	fi
	zle reset-prompt
    }
    zle -N personal-fzf-history
    bindkey "^r" personal-fzf-history
}
