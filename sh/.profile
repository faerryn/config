gui() {
	case "${1}" in
		dwm)
			protocol=x11
			cmd=dwm
			;;
		*)
			return 1
	esac

	export XCURSOR_SIZE=24
	export XKB_DEFAULT_OPTIONS="caps:escape"
	export XDG_TERMINAL=st
	case "${protocol}" in
		x11)
			export MOZ_X11_EGL=1
			export XAUTHORITY="${XDG_RUNTIME_DIR}"/Xauthority
			startx $(which dbus-run-session) ${cmd}
			;;
		wayland)
			export MOZ_ENABLE_WAYLAND=
			export QT_QPA_PLATFORM=wayland-egl
			export SDL_VIDEODRIVER=wayland
			dbus-run-session ${cmd}
			;;
	esac
}
if test -z "${DISPLAY}${WAYLAND_DISPLAY}" && test $(tty) = /dev/tty1; then
	wm=0
	while test -n "${wm}"; do
		read wm
		exec gui ${wm}
	done
fi
