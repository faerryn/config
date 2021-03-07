# Prompt
PS1='\w\n\$ '

# History
HISTFILE="${XDG_CACHE_HOME}"/bash_history
mkdir -p "$(dirname "${HISTFILE}")"
export HISTCONTROL=ignoreboth:erasedups

# Navigation
shopt -s autocd

# Aliases
alias fd='fd -H'
alias rg='rg --hidden'

alias grep='grep --color=auto'
alias diff='diff --color=auto'

alias ls='ls -hvxCFX --color=auto --group-directories-first'
alias ll='ls -g'
alias la='ls -gA'

alias xclip='xclip -selection clipboard'
