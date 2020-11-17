gui() {
	wm="${1}"
	case "${wm}" in
		dwm)
			protocol=x11
			cmd=dwm
			;;
		river)
			protocol=wayland
			cmd='river -c '"${XDG_CONFIG_HOME}"/river.sh
			;;
		*)
			return 1
	esac

	export XCURSOR_SIZE=24
	export XKB_DEFAULT_OPTIONS="caps:escape"
	case "${protocol}" in
		x11)
			export XDG_TERMINAL=st
			export XAUTHORITY="${XDG_RUNTIME_DIR}"/Xauthority
			exec startx $(which dbus-run-session) ${cmd}
			;;
		wayland)
			export XDG_TERMINAL=st
			export MOZ_ENABLE_WAYLAND=
			export QT_QPA_PLATFORM=wayland-egl
			export SDL_VIDEODRIVER=wayland
			exec dbus-run-session ${cmd}
			;;
	esac
}
if test -z "${DISPLAY}${WAYLAND_DISPLAY}" && test $(tty) = /dev/tty1; then
	wm=0
	while test -n "${wm}"; do
		read wm
		gui ${wm}
	done
fi
