#!/bin/sh

case ${1} in
	lock)
		swaylock -f -c 000000
		;;
	reload)
		sway reload
		;;
	exit)
		loginctl terminate-session $XDG_SESSION_ID
		;;
	shutdown)
		doas shutdown -P now
		;;
	reboot)
		doas shutdown -r now
		;;
	suspend)
		sway output '*' enable
		doas zzz
		;;
	hibernate)
		sway output '*' enable
		doas zzz -Z
		;;
	*)
		echo 'lock\nreload\nexit\nshutdown\nreboot\nsuspend\nhibernate'
esac
