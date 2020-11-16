gui() {
	protocol=${1}
	shift
	if ! command -v "${1}"; then
		return 1
	fi
	. ~/loc/gui.sh
	export XCURSOR_SIZE=24
	export TERMINAL=st
	case "${protocol}" in
		x11)
			export XAUTHORITY="${XDG_RUNTIME_DIR}"/Xauthority
			exec startx $(which dbus-run-session) $@
			;;
		wayland)
			export MOZ_ENABLE_WAYLAND=
			export QT_QPA_PLATFORM=wayland-egl
			export SDL_VIDEODRIVER=wayland
			exec dbus-run-session $@
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
				gui x11 dwm
				;;
		esac
	done
fi
