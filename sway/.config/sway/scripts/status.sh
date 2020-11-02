#!/bin/sh

volume_module() {
	vol=$(aucatctl master | cut -d'=' -f2)
	if test $vol -gt 96; then
		echo 
	elif test $vol -gt 32; then
		echo 
	elif test $vol -gt 0; then
		echo 
	else
		echo 
	fi
}

battery_module() {
	bat=$(cat /sys/class/power_supply/BAT*/capacity)
	if test $bat -gt 80; then
		echo 
	elif test $bat -gt 60; then
		echo 
	elif test $bat -gt 40; then
		echo 
	elif test $bat -gt 20; then
		echo 
	else
		echo 
	fi
}

echo "$(date +'%r, %D,') $(volume_module), $(battery_module)"
