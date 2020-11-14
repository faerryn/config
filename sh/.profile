gui() {
	if ! command -v "${2}"; then
		return 1
	fi
	case "${1}" in
		x11)
			export XAUTHORITY="${XDG_RUNTIME_DIR}"/Xauthority
			exec dbus-run-session startx ${2}
			;;
		wayland)
			export MOZ_ENABLE_WAYLAND=
			export QT_QPA_PLATFORM=wayland-egl
			export SDL_VIDEODRIVER=wayland
			exec dbus-run-session ${2}
			;;
		*)
			return 1
			;;
	esac
}

if test -z "${DISPLAY}${WAYLAND_DISPLAY}" && test $(tty) = /dev/tty1; then
	while true; do
		read wm
		if test -z "${wm}"; then
			break
		fi
		case "${wm}" in
			dwm)
				gui x11 "${HOME}"/.config/dwm.sh
				;;
		esac
	done
fi
