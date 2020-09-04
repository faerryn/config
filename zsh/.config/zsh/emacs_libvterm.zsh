if [[ "$INSIDE_EMACS" == vterm ]]; then
    function vterm_printf () { printf "\e]%s\e\\" "$1" }
    function vterm_prompt_end () { vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"; }
    setopt PROMPT_SUBST
    PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'
    function vterm_cmd () {
	local vterm_elisp
	vterm_elisp=""
	while [ $# -gt 0 ]; do
	    vterm_elisp="$vterm_elisp""$(printf '"%s" ' "$(printf "%s" "$1" | sed -e 's|\\|\\\\|g' -e 's|"|\\"|g')")"
	    shift
	done
	vterm_printf "51;E$vterm_elisp"
    }
    function emacs () { vterm_cmd find-file "$(realpath "$@")" }
fi
