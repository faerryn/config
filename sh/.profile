wayland_run () {
	if ! command -v "${1}"; then
		return 1
	fi
	export SDL_VIDEODRIVER=wayland
	export MOZ_ENABLE_WAYLAND=1
	export QT_QPA_PLATFORM=wayland-egl
	exec dbus-run-session ${1}
}

x11_run () {
	if ! command -v "${1}"; then
		return 1
	fi
	export XAUTHORITY="${XDG_RUNTIME_DIR}"/Xauthority
	exec dbus-run-session ${1}
}

if test -z "${DISPLAY}${WAYLAND_DISPLAY}" && test $(tty) = /dev/tty1; then
	wayland_run sway
fi
