function () {
    # Ensure that profile is sourced
    if [[ ! -v $PERSONAL_PROFILE ]]; then
	source "$HOME/.profile"
    fi

    # Empty out precmd_functions and preexec_functions
    precmd_functions=()
    preexec_functions=()

    # Plugins
    local PLUGIN
    for PLUGIN in $XDG_CONFIG_HOME/zsh/*/*.plugin.zsh; do source $PLUGIN; done

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
    async_init
    function personal_git_prompt () {
	cd -q $1
	pwd
	git --no-optional-locks status --branch --porcelain=v2 2>&1 |
	    awk -f $XDG_CONFIG_HOME/zsh/gitprompt.awk
    }
    function personal_prompt_callback () {
	if [[ -z $5 ]]; then
	    local OUTPUT=("${(f)3}")
	    if [[ $6 -eq 0 ]] && [[ "$OUTPUT[1]" == "$PWD" ]]; then
		RPROMPT="$OUTPUT[2]"
		zle reset-prompt
	    fi
	else
	    personal_start_prompt_worker
	fi
    }
    function personal_start_prompt_worker () {
	async_job "personal_prompt_worker" personal_git_prompt $PWD
    }
    precmd_functions+=(personal_start_prompt_worker)
    async_start_worker "personal_prompt_worker" -n
    async_register_callback "personal_prompt_worker" personal_prompt_callback

    # Vi-mode
    bindkey -v
    bindkey -M viins "^?" backward-delete-char

    KEYTIMEOUT=1

    local function personal_cursor_block () { echo -ne "\e[2 q" }
    local function personal_cursor_beam () { echo -ne "\e[6 q" }

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

    bindkey '^R' history-incremental-search-backward

    # fzf
    function personal_fzf_file () {
	local WORD="${LBUFFER##* }"
	local EXPANDED_WORD=$(realpath --relative-base=/ --relative-to=$PWD $~WORD 2>/dev/null)
	local DIRECTORY="$EXPANDED_WORD"
	local DIRECTORY_LEN=${#DIRECTORY}
	while [[ ! -d "$DIRECTORY" ]]; do
	    DIRECTORY="${DIRECTORY%/*}"
	    if [[ $DIRECTORY_LEN -eq ${#DIRECTORY} ]]; then
		DIRECTORY=
		DIRECTORY_LEN=0
		break;
	    fi
	    DIRECTORY_LEN=${#DIRECTORY}
	done
	local STUB=
	if [[ -z $DIRECTORY ]]; then
	    STUB="$EXPANDED_WORD"
	else
	    STUB="$EXPANDED_WORD[$(($DIRECTORY_LEN+2)),-1]"
	fi
	local FILE="$(fd -H . $~DIRECTORY | fzf --border=rounded --height=50% --query=$STUB)"
	if [[ -a $FILE ]]; then
	    LBUFFER="$LBUFFER[1,-$((${#WORD}+1))]$FILE"
	fi
	zle reset-prompt
    }
    zle -N personal_fzf_file
    bindkey "^F" personal_fzf_file

    # Completion/Correction
    autoload -Uz compinit
    mkdir -p "$XDG_CACHE_HOME/zsh"
    compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
    zstyle ':completion:*' accept-exact '*(N)'
    zstyle ':completion:*' use-cache on
    zstyle ':completion:*' cache-path ~/.zsh/cache
    setopt CORRECT
}
