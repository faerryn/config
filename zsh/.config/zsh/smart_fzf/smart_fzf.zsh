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
	local FILES="$([[ -n $DIRECTORY ]] && cd -q $~DIRECTORY; fd -tf -td | fzf --multi --height=50% --query="$SEARCH" | tr '\n' ' ')"
	if [[ -n $FILES ]]; then
		LBUFFER="$LBUFFER[1,-${#WORD}-1]$DIRECTORY$FILES"
	fi
	zle reset-prompt
}
zle -N personal_fzf_file

function personal_fzf_history () {
	local RESULT=(${(f)"$(fc -lr 0 | sed -r 's/^\s*[0-9]+\*?\s*//' | fzf --print-query --height=50% --no-sort --query=$BUFFER)"})
	[[ -n "$RESULT[2]" ]]\
		&& LBUFFER="$(echo $RESULT[2] | sed -r 's/\\n/\n/g')"\
		|| LBUFFER="$RESULT[1]"
	RBUFFER=
	zle reset-prompt
}
zle -N personal_fzf_history

bindkey "^X^F" personal_fzf_file
bindkey "^R" personal_fzf_history
