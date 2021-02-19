PS1='$(
e=${?}
test ${e} -ne 0 && echo "${e} | "
)\w
$ '

HISTFILE="${XDG_CACHE_HOME}"/bash_history
mkdir -p "$(dirname "${HISTFILE}")"
export HISTCONTROL=ignoreboth:erasedups

shopt -s dotglob extglob globstar

dc () {
	case "${1}" in
		*[!0-9]*)
			return 1
			;;
		'')
			cd ..
			;;
		*)
			if test ${1} -gt 0 && test "${PWD}" != /; then
				cd ..
				dc $((${1}-1))
			fi
			;;
	esac
}

alias ..=dc

alias fd='fd --hidden'
alias rg='rg --hidden'

alias grep='grep --color=auto'
alias diff='diff --color=auto'

alias ls='ls -hvxCFX --color=auto --group-directories-first'
alias ll='ls -g'
alias la='ls -gA'

alias rm='rm -i'

alias xclip='xclip -selection clipboard'
