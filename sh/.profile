gui() {
	protocol="${1}"
	shift
	export XCURSOR_SIZE=24
	export XKB_DEFAULT_OPTIONS="caps:escape"
	export XDG_TERMINAL=st
	case "${protocol}" in
		x11)
			export MOZ_X11_EGL=1
			export XAUTHORITY="${XDG_RUNTIME_DIR}"/Xauthority
			which dbus-run-session | xargs -I{} startx {} ${@} # if dbus doesn't exist, just start x (xargs -r would prevent this)
			;;
		wayland)
			export MOZ_ENABLE_WAYLAND=
			export QT_QPA_PLATFORM=wayland-egl
			export SDL_VIDEODRIVER=wayland
			dbus-run-session ${@} || ${@} # if dbus doesn't exist, just run the wayland
			;;
	esac
}
if test -z "${DISPLAY}${WAYLAND_DISPLAY}" && test $(tty) = /dev/tty1; then
	exec gui x11 dwm
fi
