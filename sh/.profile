if test $(tty) = /dev/tty1; then
	read wm
	exec xinit "$(which dbus-run-session)" "${wm}"
fi
