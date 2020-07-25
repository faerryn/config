# Aliases
alias la="ls -a"
alias ll="ls -l"
alias lla="ll -la"
alias ec="emacsclient"
alias em="emacs"

# Prompt
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_SEPARATOR=""

ZSH_THEME_GIT_PROMPT_DETACHED="%B%F{yellow}:"
ZSH_THEME_GIT_PROMPT_BRANCH="%B%F{blue}"

ZSH_THEME_GIT_PROMPT_UPSTREAM_SYMBOL=""
ZSH_THEME_GIT_PROMPT_UPSTREAM_PREFIX="%F{yellow}("
ZSH_THEME_GIT_PROMPT_UPSTREAM_SUFFIX=")"

ZSH_THEME_GIT_PROMPT_BEHIND=" %F{red}↓"
ZSH_THEME_GIT_PROMPT_AHEAD=" %F{green}↑"

ZSH_THEME_GIT_PROMPT_UNMERGED=" %F{red}!"
ZSH_THEME_GIT_PROMPT_STAGED=" %F{green}+"
ZSH_THEME_GIT_PROMPT_UNSTAGED=" %F{red}-"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %F{yellow}?"
ZSH_THEME_GIT_PROMPT_STASHED=" %F{cyan}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_GIT_PROMPT_SHOW_UPSTREAM="full"

source "$XDG_CONFIG_HOME/zsh/plugins/git-prompt.zsh/git-prompt.zsh"

PROMPT=" %F{blue}%c%f %(1j.%F{yellow}*%f .)%(0?..%F{red})%(!.#.$)%f "
RPROMPT="\$(gitprompt)"

# Auto-cd
setopt AUTO_CD

# Vi-mode
bindkey -v

KEYTIMEOUT=1

function cursor_beam() { echo -ne "\e[5 q" }

function zle-line-init() { cursor_beam }
zle -N zle-line-init

function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = "block" ]]; then
	echo -ne "\e[1 q"
    elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = "" ]] || [[ $1 = "beam" ]]; then
	cursor_beam
    fi
}
zle -N zle-keymap-select

precmd_functions+=(cursor_beam)
cursor_beam

# Completion
autoload -Uz compinit && mkdir -p "$HOME/.cache/zsh" && compinit -d "$HOME/.cache/zsh/zcompdump-$ZSH_VERSION"
source "$XDG_CONFIG_HOME/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Highlighting
source "$XDG_CONFIG_HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# History
mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
SAVEHIST=1000
HISTSIZE=1000
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }
source "$XDG_CONFIG_HOME/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
bindkey -M vicmd "^p" history-substring-search-up
bindkey -M vicmd "^n" history-substring-search-down

# Vi-mode yank and paste
source "$XDG_CONFIG_HOME/zsh/plugins/zsh-system-clipboard/zsh-system-clipboard.zsh"

# FZF
if ! command -v fzf >/dev/null && [[ ! -a "$XDG_CONFIG_HOME/zsh/plugins/fzf/bin/fzf" ]]; then
    "$XDG_CONFIG_HOME/zsh/plugins/fzf/install" --bin
fi
if ! command -v fzf >/dev/null; then
    export PATH="$XDG_CONFIG_HOME/zsh/plugins/fzf/bin:$PATH"
fi
export FZF_CTRL_T_COMMAND="fd --hidden --no-ignore-vcs --type=file"
export FZF_ALT_C_COMMAND="fd --hidden --no-ignore-vcs --type=directory"
source "$XDG_CONFIG_HOME/zsh/plugins/fzf/shell/key-bindings.zsh"
