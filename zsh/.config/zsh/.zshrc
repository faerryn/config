# Empty out precmd_functions and preexec_functions
precmd_functions=()
preexec_functions=()

# zinit
declare -A ZINIT
ZINIT[HOME_DIR]="${XDG_DATA_HOME}"/zinit
ZINIT[BIN_DIR]="${ZINIT[HOME_DIR]}"/bin
ZINIT[ZCOMPDUMP_PATH]="${XDG_CACHE_HOME}"/zsh/zcompdump-"${ZSH_VERSION}"
ZINIT[COMPINIT_OPTS]="-d ${ZINIT[ZCOMPDUMP_PATH]} -C"

if [[ ! -d "${ZINIT[BIN_DIR]}" ]] {
	git clone --depth 1 https://github.com/zdharma/zinit.git "${ZINIT[BIN_DIR]}"
}

source "${ZINIT[BIN_DIR]}"/zinit.zsh

zinit silent compile wait'!0' for \
	light-mode mafredri/zsh-async \
	light-mode "${XDG_CONFIG_HOME}"/zsh/prompt \
	light-mode has'fzf' "${XDG_CONFIG_HOME}"/zsh/fzf \
	light-mode zsh-users/zsh-completions \
	light-mode atinit'zicompinit' zsh-users/zsh-syntax-highlighting

# Navigation
function dc () {
	1="${1:-1}"
	[[ ! "${1}" =~ ^[0-9]+$ ]] && return 1
	repeat ${1} { cd '..' }
}
alias ..=dc

# Emacs
bindkey -e

# ^Z for fg
function personal_fg () {
	if [[ -n "${BUFFER}" ]] { return }
	fg
	zle reset-prompt
}
zle -N personal_fg
bindkey '^Z' personal_fg

# ^X^E to edit current BUFFER in editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# History
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY EXTENDED_HISTORY
mkdir -p "${XDG_DATA_HOME}"/zsh
HISTFILE="${XDG_DATA_HOME}"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000

# Completion/Correction/Suggestion
setopt CORRECT
zstyle ':completion:*' accept-exact '*(N)'

# Aliases
alias ls='ls -hvxCFX --color=auto --group-directories-first'
alias ll='ls -g'
alias la='ls -gA'

alias grep='grep --color=auto'

alias fd="fd --hidden --ignore-file ${XDG_CONFIG_HOME}/git/ignore"
alias rg="rg --hidden --ignore-file ${XDG_CONFIG_HOME}/git/ignore"
