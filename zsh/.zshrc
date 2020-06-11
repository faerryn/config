# Lines configured by zsh-newuser-install
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
# End of lines added by compinstall

# Zsh options
setopt HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE SHARE_HISTORY
setopt EXTENDED_GLOB

# Editing
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim -c 'set ft=man' -"
alias v="nvim"

# ls(exa) aliases
alias l="exa --git"
alias la="exa -la --git"
alias ll="exa -l --git"

# misc aliases
alias g="git"
alias s="sudo"
alias se="sudoedit"

# Prompt
setopt PROMPT_SUBST
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' max-exports 3

zstyle ':vcs_info:*' formats '%b' '%u' '%c'
zstyle ':vcs_info:*' actionformats '%b|%a' '%u' '%c'

function precmd() {
  vcs_info
  if [[ -n ${vcs_info_msg_0_} ]]; then
    local VCS_INFO_COMP="("
    if [[ -n ${vcs_info_msg_1_} ]]; then
      VCS_INFO_COMP="${VCS_INFO_COMP}%F{red}"
    else
      if [[ -n ${vcs_info_msg_2_} ]]; then
	VCS_INFO_COMP="${VCS_INFO_COMP}%F{yellow}"
      else
	VCS_INFO_COMP="${VCS_INFO_COMP}%F{green}"
      fi
    fi
    local REMOTE="$(git remote)"
    VCS_INFO_COMP="${VCS_INFO_COMP}${REMOTE}/${vcs_info_msg_0_}%f)"
    local AHEAD="$(git rev-list HEAD --not ${REMOTE} --count)"
    if [[ ${AHEAD} > 0 ]]; then
      VCS_INFO_COMP="${VCS_INFO_COMP}{%F{cyan}${AHEAD}↑%f}"
    fi
    local BEHIND="$(git rev-list ${REMOTE} --not HEAD --count)"
    if [[ ${BEHIND} > 0 ]]; then
      VCS_INFO_COMP="${VCS_INFO_COMP}{%F{magenta}${BEHIND}↓%f}"
    fi
  fi
  PROMPT="[%F{blue}%c%f]%(0?..%F{red})%(!.#.$)%f "
  RPROMPT="${VCS_INFO_COMP}"
}

# Change cursor shape for different vi modes.
export KEYTIMEOUT=1
zle -N zle-keymap-select
function zle-keymap-select() {
  if [[ ${KEYMAP} = vicmd ]] || [[ $1 = "block" ]]; then
      echo -ne "\e[1 q"
    elif [[ ${KEYMAP} = main ]] || [[ ${KEYMAP} = viins ]]\
      || [[ ${KEYMAP} = "" ]] || [[ $1 = "beam" ]]; then
	  echo -ne "\e[5 q"
  fi
}
function zle-line-init() { echo -ne "\e[5 q" }

# Edit line in vim with alt-e:
autoload edit-command-line
zle -N edit-command-line
bindkey '^[e' edit-command-line

# fzf
for FZF_ZSH_DIR in "/usr/share/fzf" "$HOME/.fzf/shell"; do
  if [ -d "$FZF_ZSH_DIR" ]; then
    . "$FZF_ZSH_DIR/completion.zsh"
    . "$FZF_ZSH_DIR/key-bindings.zsh"
    break
  fi
done
export FZF_ALT_C_COMMAND="fd -HL -E '**/.git/' -td . \$dir"
export FZF_CTRL_T_COMMAND="fd -HL -E '**/.git/' -tf . \$dir"
export FZF_DEFAULT_COMMAND="fd -HL -E '**/.git/' -tf"
