#!/bin/sh
dmenu-wl -fn 'monospace 12' -h 26 -m $(swaymsg -t get_outputs | jq -r 'map(.focused) | index(true)')
