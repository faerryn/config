# Copyright (c) 2020 Jiang Meng Liao (Faerryn) <alexandre.liao@gmail.com>
function personal_fzf_file () {
	local word="${LBUFFER##* }"
	local parts=(${(s:/:)word})
	if [[ "$word[1]" = "/" ]] {
		local pre="/"
	}
	local directory="$pre${(j:/:)parts}"
	while [[ ! -d $~directory ]] && [[ ${#parts[@]} -gt 0 ]] {
		parts=($parts[1,-2])
		directory="$pre${(j:/:)parts}"
	}
	if [[ -n "$directory" ]] && [[ ! "$directory" =~ \/$ ]] {
		directory="$directory/"
	}
	local search="$word[${#directory}+1,-1]"
	local output="$([[ -n $directory ]] && cd -q $~directory; fd -tf -td | fzf --multi --height=50% --query="$search" | tr '\n' ' ')"
	if [[ -n $output ]] {
		LBUFFER="$LBUFFER[1,-${#word}-2]"
		local files=(${(s: :)output})
		local file=""
		for file in $files; {
			LBUFFER="$LBUFFER $directory$file"
		}
	}
	zle reset-prompt
}
zle -N personal_fzf_file

function personal_fzf_history () {
	local output="$(fc -lr 0 | sed -r 's/^\s*[0-9]+\*?\s*//' | fzf --height=50% --no-sort --query=$BUFFER)"
	if [[ -n "$output" ]] {
		LBUFFER="$output"
		RBUFFER=
	}
	zle reset-prompt
}
zle -N personal_fzf_history

bindkey "^X^F" personal_fzf_file
bindkey "^R" personal_fzf_history
