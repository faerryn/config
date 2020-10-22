#!/bin/sh
module_date_time () {
	date +'%Y-%m-%d %l:%M:%S %p'
}
module_charge () {
	battery=/sys/class/power_supply/$1
	echo $((100*$(cat $battery/charge_now)/$(cat $battery/charge_full)))% $(cat $battery/status)
}
echo "$(module_date_time) $(module_charge BAT1)"
