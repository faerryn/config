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
		sudo zzz
		;;
	hibernate)
		sway output '*' enable
		sudo zzz -Z
		;;
	shutdown)
		sudo shutdown -P now
		;;
	reboot)
		sudo shutdown -r now
		;;
	*)
		echo 'lock\nreload\nlogout\nsuspend\nhibernate\nshutdown\nreboot'
esac
