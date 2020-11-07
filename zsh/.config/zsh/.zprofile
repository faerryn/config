if test -z "$DISPLAY" && test -z "$WAYLAND_DISPLAY" && test $(tty) = /dev/tty1; then
	while true; do
		read wm
		if command -v $wm; then
			exec dbus-run-session $wm
		else
			echo "$wm not found"
		fi
	done
fi
