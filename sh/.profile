wayland_run () {
	export MOZ_ENABLE_WAYLAND=
	export QT_QPA_PLATFORM=wayland-egl
	export SDL_VIDEODRIVER=wayland
	exec dbus-run-session ${1}
}

x11_run () {
	export XAUTHORITY="${XDG_RUNTIME_DIR}"/Xauthority
	exec dbus-run-session startx ${1}
}

if test -z "${DISPLAY}${WAYLAND_DISPLAY}" && test $(tty) = /dev/tty1; then
	while true; do
		read wm
		if test -z "${wm}"; then
			break
		fi
		case "${wm}" in
			sway)
				wayland_run sway
				;;
			dwm)
				x11_run "${HOME}"/.config/dwm.sh
				;;
		esac
	done
fi
