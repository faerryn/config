#!/bin/sh

module_charge () {
	for battery in /sys/class/power_supply/BAT*; do
		echo $(basename $battery): $(cat $battery/capacity)% $(cat $battery/status)
	done
}

module_sound () {
	echo VOL: $((100*$(aucatctl master | cut -d'=' -f2)/127))
}

echo "| $(module_sound)% | $(date +'%r') | $(date +'%a, %b %d %Y') | $(module_charge) |"
