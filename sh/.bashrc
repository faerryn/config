HISTFILE="$XDG_DATA_HOME"/bash/history
PS1='$(
builtin typeset e=${?}
test ${e} -ne 0 && echo "[91m${e}[97m | "
)[92m${USER}[97m@[92m${HOSTNAME:=$(hostname)}[97m [94m${PWD/#${HOME}/\~}[97m
${0} $ ]0;${PWD/#${HOME}/\~} ${TERM}'

alias ls='ls -hvxCFX --color=auto --group-directories-first'
alias ll='ls -g' la='ls -gA'

alias grep='grep --color=auto' diff='diff --color=auto'

alias fd='fd --hidden --ignore-file '"${XDG_CONFIG_HOME}"/git/ignore
alias rg='rg --hidden --ignore-file '"${XDG_CONFIG_HOME}"/git/ignore
