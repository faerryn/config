if test $(tty) = /dev/tty1; then
	exec xinit "$(which dbus-run-session)" dwm
fi
