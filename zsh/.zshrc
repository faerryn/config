function () {
    # Ensure that profile is sourced
    if [[ ! -v $PERSONAL_PROFILE ]]; then
	source "$HOME/.profile"
    fi

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
    PROMPT=" %F{blue}%3~%f %(1j.%F{yellow}*%f .)%(2L.%F{green}+%f .)%(0?..%F{red})%(!.#.$)%f "

    # Vi-mode
    bindkey -v

    KEYTIMEOUT=1

    local function cursor_block () { echo -ne "\e[2 q" }
    local function cursor_beam () { echo -ne "\e[6 q" }

    function zle-line-init () { cursor_beam }
    zle -N zle-line-init

    function zle-keymap-select () {
	if [[ ${KEYMAP} == vicmd ]]; then
	    cursor_block
	elif [[ ${KEYMAP} == main ]]; then
	    cursor_beam
	fi
    }

    zle -N zle-keymap-select

    precmd_functions+=(cursor_beam)
    preexec_functions+=(cursor_block)
    cursor_beam

    # History
    mkdir -p "$XDG_DATA_HOME/zsh"
    HISTFILE="$XDG_DATA_HOME/zsh/history"
    HISTSIZE=1000000
    SAVEHIST=1000000
    setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY EXTENDED_HISTORY

    # Completion
    autoload -Uz compinit && mkdir -p "$HOME/.cache/zsh" && compinit -d "$HOME/.cache/zsh/zcompdump-$ZSH_VERSION"

    # FZF
    if [[ ! -a "$XDG_CONFIG_HOME/zsh/fzf/bin/fzf" ]]; then
	"$XDG_CONFIG_HOME/zsh/fzf/install" --bin
    fi
    if ! command -v fzf >/dev/null; then
	export PATH="$XDG_CONFIG_HOME/zsh/fzf/bin:$PATH"
    fi

    function personal-fzf-file () {
	local WORD="${LBUFFER##* }"
	local STUB="${WORD##*/}"
	local DIRECTORY="$WORD[1,-$((${#STUB}+1))]"
	if [[ ! -d $DIRECTORY ]]; then
	    STUB="$DIRECTORY$STUB"
	    DIRECTORY=
	fi
	local FILE="$(fd -Htf . $~DIRECTORY 2>/dev/null | fzf --border=rounded --height=50% --query=$STUB)"
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
	local LINE="$(fc -lr 0 | sed -r 's/^\s*[0-9]+\s*//' | fzf --border=rounded --height=50% --no-sort --query=$BUFFER)"
	if [[ -n $LINE ]]; then
	    LBUFFER="$LINE"
	    RBUFFER=
	fi
	zle reset-prompt
    }
    zle -N personal-fzf-history
    bindkey "^r" personal-fzf-history

    # Plugins
    local PLUGIN
    for PLUGIN in $XDG_CONFIG_HOME/zsh/*/*.plugin.zsh; do
	source $PLUGIN
    done
}
