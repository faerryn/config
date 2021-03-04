autoload -Uz compinit promptinit
compinit
promptinit

prompt fade blue

autoload -Uz compinit
compinit

setopt COMPLETE_ALIASES

bindkey -e

alias fd='fd --hidden'
alias rg='rg --hidden'

alias grep='grep --color=auto'
alias diff='diff --color=auto'

alias ls='ls -hvxCFX --color=auto --group-directories-first'
alias ll='ls -g'
alias la='ls -gA'

alias rm='rm -i'

alias xclip='xclip -selection clipboard'
