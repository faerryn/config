#!/bin/sh

module_date_time () {
	date
}

module_charge () {
	battery=/sys/class/power_supply/${1:-BAT1}
	echo $(cat $battery/capacity)% $(cat $battery/status)
}

module_sound () {
	echo $((100*$(aucatctl master | cut -d'=' -f2)/127))
}

echo "| vol: $(module_sound)% | $(module_date_time) | $(module_charge) |"