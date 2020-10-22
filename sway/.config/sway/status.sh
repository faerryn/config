#!/bin/sh

module_date_time () {
	date +'%Y-%m-%d %l:%M:%S %p'
}

module_charge () {
	battery=/sys/class/power_supply/${1:-BAT1}
	echo $(cat $battery/capacity)% $(cat $battery/status)
}

echo "| $(module_date_time) | $(module_charge) |"
