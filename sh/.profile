mkdir -m 700 -p "${GNUPGHOME}"
if test -z "${DISPLAY}${WAYLAND_DISPLAY}" && test $(tty) = /dev/tty1; then
	exec gui x11 dwm
fi
