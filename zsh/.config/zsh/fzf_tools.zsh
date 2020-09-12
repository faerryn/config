# Copyright (c) 2020 Jiang Meng Liao (Faerryn) <alexandre.liao@gmail.com>

function personal_fzf_file () {
	local WORD="${LBUFFER##* }"
	local PIECES=(${(s:/:)WORD})
	local DIRECTORY="$PRE${(j:/:)PIECES}"
	[[ $WORD[1] = "/" ]] && local PRE="/" || local PRE=
	while [[ ! -d $~DIRECTORY ]] && [[ ${#PIECES[@]} -gt 0 ]]; do
		PIECES=($PIECES[1,-2])
		DIRECTORY="$PRE${(j:/:)PIECES}"
	done
	[[ -n $DIRECTORY ]] && DIRECTORY="$DIRECTORY/"
	local SEARCH="$WORD[${#DIRECTORY}+1,-1]"
	local FILE="$([[ -n $DIRECTORY ]] && cd -q $~DIRECTORY; fd -tf -td | fzf-tmux --height=50% --query="$SEARCH")"
	if [[ -n $FILE ]]; then
		LBUFFER="$LBUFFER[1,-${#WORD}-1]$DIRECTORY$FILE"
	fi
	zle reset-prompt
}
zle -N personal_fzf_file

function personal_fzf_history () {
	local LINE="$(fc -lr 0 | sed -r 's/^\s*[0-9]+\*?\s*//' | fzf-tmux --height=50% --no-sort --query=$BUFFER)"
	if [[ -n $LINE ]]; then
		LBUFFER="$LINE"
		RBUFFER=
	fi
	zle reset-prompt
}
zle -N personal_fzf_history

bindkey "^x^f" personal_fzf_file
bindkey "^r" personal_fzf_history
