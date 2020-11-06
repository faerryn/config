#!/bin/sh
dmenu-wl -i -nb '#282C34' -nf '#DCDFE4' -sb '#61AFEF' -sf '#282C34' -fn 'monospace 12' -h 26 -m $(swaymsg -t get_outputs | jq -r 'map(.focused) | index(true)')
