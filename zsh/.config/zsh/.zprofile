if test -z "$DISPLAY" && test -z "$WAYLAND_DISPLAY" && test $(tty) = /dev/tty1; then
	exec dbus-run-session sway
fi
