#!/bin/sh

case ${1} in
	lock)
		swaylock -f -c 000000
		;;
	reload)
		sway reload
		;;
	logout)
		loginctl terminate-session $XDG_SESSION_ID
		;;
	suspend)
		sway output '*' enable
		doas zzz
		;;
	hibernate)
		sway output '*' enable
		doas zzz -Z
		;;
	shutdown)
		doas shutdown -P now
		;;
	reboot)
		doas shutdown -r now
		;;
	*)
		echo 'lock\nreload\nlogout\nsuspend\nhibernate\nshutdown\nreboot'
esac
