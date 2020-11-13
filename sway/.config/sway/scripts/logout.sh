#!/bin/sh

case ${1} in
	lock)
		swaylock -f -c 000000
		;;
	exit)
		sway exit
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
		echo 'lock\nexit\nshutdown\nreboot\nsuspend\nhibernate'
esac
