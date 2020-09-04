KEYTIMEOUT=1

function personal_cursor_block () { echo -ne "\e[2 q" }
function personal_cursor_beam () { echo -ne "\e[6 q" }

precmd_functions+=(personal_cursor_beam)
preexec_functions+=(personal_cursor_block)

function zle-keymap-select () {
    if [[ ${KEYMAP} == vicmd ]]; then
	personal_cursor_block
    elif [[ ${KEYMAP} == main ]]; then
	personal_cursor_beam
    fi
}
zle -N zle-keymap-select
