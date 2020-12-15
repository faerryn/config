if test -z "${DISPLAY}${WAYLAND_DISPLAY}" && test "$(tty)" = /dev/tty1; then
	exec gui wayland hikari
	# exec gui x11 emacs --fullscreen --exwm
fi
