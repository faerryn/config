PS1='\w\n\$ '

HISTFILE="${XDG_CACHE_HOME}"/bash_history
mkdir -p "$(dirname "${HISTFILE}")"
export HISTCONTROL=ignoreboth:erasedups

shopt -s dotglob extglob globstar
shopt -s autocd

alias fd='fd --hidden'
alias rg='rg --hidden'

alias grep='grep --color=auto'
alias diff='diff --color=auto'

alias ls='ls -hvxCFX --color=auto --group-directories-first'
alias ll='ls -g'
alias la='ls -gA'

alias rm='rm -i'

alias xclip='xclip -selection clipboard'
