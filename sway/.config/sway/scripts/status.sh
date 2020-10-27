#!/bin/sh

module_charge () {
	battery=/sys/class/power_supply/${1:-BAT1}
	echo $(cat $battery/capacity)% $(cat $battery/status)
}

module_sound () {
	echo VOL: $((100*$(aucatctl master | cut -d'=' -f2)/127))
}

echo "| $(module_sound)% | $(date +'%r') | $(date +'%a, %b %d %Y') | $(module_charge) |"
