PS1='$(
builtin typeset e=${?}
test ${e} -ne 0 && echo "[91m${e}[97m | "
)[92m${USER}[97m@[92m${HOSTNAME:=$(hostname)}[97m [94m${PWD/#${HOME}/\~}[97m
$(basename ${0}) $ ]0;${PWD/#${HOME}/\~} ${TERM}'

HISTFILE="$XDG_DATA_HOME"/bash/history
dirname "${HISTFILE}" | xargs mkdir -p

HISTSIZE=65535

shopt -s extglob

_dc() {
	dirs_back="${1:-1}"
	case "${dirs_back}" in
		+([0-9]))
			if [ "${PWD}" != / ] && [[ ${dirs_back} -gt 0 ]]; then
				cd ..
				_dc $((${dirs_back}-1))
			fi
			;;
		*)
			return 1
			;;
	esac
}
alias ..=_dc

alias ls='ls -hvxCFX --color=auto --group-directories-first'
alias ll='ls -g' la='ls -gA'

alias grep='grep --color=auto' diff='diff --color=auto'

alias fd='fd --hidden --ignore-file '"${XDG_CONFIG_HOME}"/git/ignore
alias rg='rg --hidden --ignore-file '"${XDG_CONFIG_HOME}"/git/ignore
