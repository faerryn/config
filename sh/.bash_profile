[[ -f ~/.profile ]] && . ~/.profile
case "${-}" in
	*i*)
		. ~/.bashrc
		;;
esac
