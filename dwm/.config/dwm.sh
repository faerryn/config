#!/bin/sh
xdg-user-dirs-update
sxhkd &
. ~/loc/dwm.sh
exec dwm
