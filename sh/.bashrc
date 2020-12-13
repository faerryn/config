PS1='${PWD/#${HOME}/\~} $ '

alias fd='fd --hidden --ignore-file '"${XDG_CONFIG_HOME}"'/git/ignore'
alias rg='rg --hidden --ignore-file '"${XDG_CONFIG_HOME}"'/git/ignore'

alias grep='grep --color=auto'
alias diff='diff --color=auto'

alias ls='ls -hvxCFX --color=auto --group-directories-first'
alias ll='ls -g'
alias la='ls -gA'
