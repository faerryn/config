#!/bin/sh
unset TERM
export _JAVA_AWT_WM_NONREPARENTING=1
export MOZ_X11_EGL=1
export SDL_VIDEODRIVER=x11

slstatus &
picom &
redshift &
hsetroot -solid '#282828'

exec dwm
