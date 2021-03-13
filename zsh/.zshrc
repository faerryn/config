# Prompt
autoload -Uz promptinit
promptinit
prompt redhat

# Bindings
bindkey -e

# Aliases
alias fd='\fd -H'
alias rg='\rg --hidden'

alias grep='\grep --color=auto'
alias diff='\diff --color=auto'

alias ls='\ls -hvxCFX --color=auto --group-directories-first'
alias ll='ls -g'
alias la='ls -gA'

# Completion
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME}"/zcompdump

# History
HISTSIZE=1000
SAVEHIST=1000
HISTFILE="${XDG_DATA_HOME}"/zhistory
setopt INC_APPEND_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_NO_STORE HIST_NO_FUNCTIONS

# Globbing
setopt BAD_PATTERN CSH_NULL_GLOB EXTENDED_GLOB GLOB GLOB_DOTS GLOB_STAR_SHORT KSH_GLOB

# Misc
setopt AUTO_CD
