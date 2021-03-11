# Prompt
autoload -Uz promptinit
promptinit
prompt redhat

# Completion
source "${XDG_CONFIG_HOME}"/zsh/nix-zsh-completions/nix-zsh-completions.plugin.zsh
fpath=("${XDG_CONFIG_HOME}"/zsh/nix-zsh-completions $fpath)
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME}"/zcompdump

# History
HISTSIZE=1000
SAVEHIST=1000
HISTFILE="${XDG_DATA_HOME}"/zhistory
setopt INC_APPEND_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_NO_STORE HIST_NO_FUNCTIONS

# Navigation
setopt AUTO_CD

# Bindings
bindkey -e

# Aliases
alias fd='\fd -H'
alias rg='\rg --hidden'

alias grep='\grep --color=auto'
alias diff='\diff --color=auto'

alias ls='\ls -hvxCFX --color=auto --group-directories-first'
alias ll='ls -1'
alias la='ls -gA'

# Direnv
>/dev/null command -v direnv && eval "$(direnv hook zsh)"
