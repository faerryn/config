if test "$(tty)" = /dev/tty1; then
	read -r wm
	exec xinit "$(which dbus-run-session)" "${wm}"
fi
