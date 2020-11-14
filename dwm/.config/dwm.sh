#!/bin/sh
sxhkd &
picom &
. ~/loc/dwm.sh
exec dwm
