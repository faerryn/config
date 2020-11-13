#!/bin/sh
xrdb ~/.config/X11/Xresources
picom &
. ~/loc/dwm.sh
exec dwm
