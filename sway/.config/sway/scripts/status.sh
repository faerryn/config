#!/bin/sh

module_charge () {
	for battery in /sys/class/power_supply/BAT*; do
		echo $(basename $battery): $(cat $battery/capacity)%
	done
}

module_sound () {
	echo VOL: $((100*$(aucatctl master | cut -d'=' -f2)/127))
}

echo "$(module_sound)%\t$(date +'%r')\t$(date +'%a, %b %d, %Y')\t$(module_charge)"
