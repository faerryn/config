# Copyright (c) 2020 Jiang Meng Liao (Faerryn) <alexandre.liao@gmail.com>
function personal_fzf_file () {
	local WORD="${LBUFFER##* }"
	local PIECES=(${(s:/:)WORD})
	[[ "$WORD[1]" = "/" ]] && local PRE="/" || local PRE=
	local DIRECTORY="$PRE${(j:/:)PIECES}"
	while [[ ! -d $~DIRECTORY ]] && [[ ${#PIECES[@]} -gt 0 ]] {
		PIECES=($PIECES[1,-2])
		DIRECTORY="$PRE${(j:/:)PIECES}"
	}
	if [[ -n "$DIRECTORY" ]] && [[ ! "$DIRECTORY" =~ \/$ ]] {
		DIRECTORY="$DIRECTORY/"
	}
	local SEARCH="$WORD[${#DIRECTORY}+1,-1]"
	local OUTPUT="$([[ -n $DIRECTORY ]] && cd -q $~DIRECTORY; fd -tf -td | fzf --multi --height=50% --query="$SEARCH" | tr '\n' ' ')"
	if [[ -n $OUTPUT ]] {
		LBUFFER="$LBUFFER[1,-${#WORD}-2]"
		local FILES=(${(s: :)OUTPUT})
		local FILE=""
		for FILE in $FILES; do
			LBUFFER="$LBUFFER $DIRECTORY$FILE"
		done
	}
	zle reset-prompt
}
zle -N personal_fzf_file

function personal_fzf_history () {
	local OUTPUT="$(fc -lr 0 | sed -r 's/^\s*[0-9]+\*?\s*//' | fzf --height=50% --no-sort --query=$BUFFER)"
	if [[ -n "$OUTPUT" ]] {
		LBUFFER="$OUTPUT"
		RBUFFER=
	}
	zle reset-prompt
}
zle -N personal_fzf_history

bindkey "^X^F" personal_fzf_file
bindkey "^R" personal_fzf_history
