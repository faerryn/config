#!/bin/sh

if ! test -p ${XDG_RUNTIME_DIR}/wobpipe; then
	mkfifo ${XDG_RUNTIME_DIR}/wobpipe
fi

# keep 'daemonized' processes here

swayidle -w\
	timeout 120 '$scripts/logout.sh lock'\
	timeout 300 '$scripts/logout.sh suspend' &
tail -f ${XDG_RUNTIME_DIR}/wobpipe | wob --background-color '#00000000'
