if test -z "$DISPLAY" && test -z "$WAYLAND_DISPLAY" && test $(tty) = /dev/tty1; then
	while true; do
		read wm
		case $wm in
			sway)
				MOZ_ENABLE_WAYLAND=1 QT_QPA_PLATFORM=wayland-egl exec dbus-run-session sway
				;;
			dwm)
				whence dwm | xargs exec XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority dbus-run-session startx
				;;
		esac
	done
fi
