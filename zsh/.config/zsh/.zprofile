wayland_run () {
	if ! command -v "${1}"; then
		return 1
	fi
	MOZ_ENABLE_WAYLAND=1 QT_QPA_PLATFORM=wayland-egl exec dbus-run-session ${1}
}

x11_run () {
	if ! command -v "${1}"; then
		return 1
	fi
	exec dbus-run-session ${1}
}

if test -z "${DISPLAY}${WAYLAND_DISPLAY}" && test $(tty) = /dev/tty1; then
	wayland_run sway
fi
