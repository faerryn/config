shopt -s extglob

HISTFILE="$XDG_DATA_HOME"/bash/history
dirname "${HISTFILE}" | xargs mkdir -p

HISTSIZE=65535

_dc() {
	dirs_back="${1:-1}"
	case "${dirs_back}" in
		+([0-9]))
			if [ "${PWD}" != / ] && [[ ${dirs_back} -gt 0 ]]; then
				builtin cd ..
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

cd() {
	builtin cd "${@}"
	ls
}

eval "$(starship init ${0})"
