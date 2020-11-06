#!/bin/sh

if ! test -p ${XDG_RUNTIME_DIR}/wobpipe; then
	mkfifo ${XDG_RUNTIME_DIR}/wobpipe
fi

pkill -x wob
tail -f ${XDG_RUNTIME_DIR}/wobpipe | wob --background-color '#00000000' &
