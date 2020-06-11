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
zstyle ':vcs_info:*' max-exports 2

zstyle ':vcs_info:*' formats '%b' '%u%c'
zstyle ':vcs_info:*' actionformats '%b|%a' '%u%c'

function precmd() {
  vcs_info
  local VCS_INFO_COMP=""
  if [[ -n ${vcs_info_msg_0_} ]]; then
    local STAGE_COLOR=""
    if [[ -n ${vcs_info_msg_1_} ]]; then
      STAGE_COLOR="%F{red}"
    else
      local REMOTE="$(git remote)"
      if [[ -n ${REMOTE} ]]; then
	if [[ "$(git rev-list HEAD --not ${REMOTE}\
	  ${REMOTE} --not HEAD --count)" > 0 ]]; then
	  STAGE_COLOR="%F{yellow}"
	else
	  STAGE_COLOR="%F{green}"
	fi
      else
	VCS_INFO_COMP="%F{green}"
      fi
    fi
    local VCS_INFO_COMP="(${STAGE_COLOR}${vcs_info_msg_0_}%f)"
  fi
  PROMPT="[%F{blue}%c%f]${VCS_INFO_COMP}%(!.#.$) "
  RPROMPT="%(0?..%F{red}%?%f)"
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
