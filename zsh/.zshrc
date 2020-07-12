# Aliases
alias la="ls -la"
alias ll="ls -l"
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

ZSH_THEME_GIT_PROMPT_UNMERGED=""
ZSH_THEME_GIT_PROMPT_STAGED=" %F{green}+"
ZSH_THEME_GIT_PROMPT_UNSTAGED=" %F{red}-"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %F{yellow}?"
ZSH_THEME_GIT_PROMPT_STASHED=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_GIT_PROMPT_SHOW_UPSTREAM="full"

source ~/.config/zsh/plugins/git-prompt.zsh/git-prompt.zsh

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
autoload -Uz compinit && mkdir -p ~/.cache/zsh && compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Highlighting
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# History
mkdir -p "$XDG_DATA_HOME/zsh"
HISTFILE="$XDG_DATA_HOME/zsh/history"
SAVEHIST=1000
HISTSIZE=1000
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }
source ~/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
bindkey -M vicmd "^p" history-substring-search-up
bindkey -M vicmd "^n" history-substring-search-down

# Vi-mode yank and paste
source ~/.config/zsh/plugins/zsh-system-clipboard/zsh-system-clipboard.zsh

# FZF
if ! command -v fzf >/dev/null; then
    ~/.local/lib/fzf/install --bin >/dev/null 2>&1
fi
export FZF_CTRL_T_COMMAND="fd --hidden --exclude=\"**/.git\" --type=file"
export FZF_ALT_C_COMMAND="fd --hidden --exclude=\"**/.git\" --type=directory"
source ~/.local/lib/fzf/shell/key-bindings.zsh
