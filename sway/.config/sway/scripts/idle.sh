#!/bin/sh
pkill -x swayidle
swayidle -w\
	timeout 120 '$scripts/logout.sh lock'\
	timeout 300 '$scripts/logout.sh suspend' &
