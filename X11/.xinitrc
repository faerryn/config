#!/bin/sh
export _JAVA_AWT_WM_NONREPARENTING="1"
export MOZ_X11_EGL="1"
export SDL_VIDEODRIVER="x11"
export XDG_TERMINAL="st -e"
export DMENU_OPTS="-x 4 -y 4"

slstatus &
picom &
redshift &
hsetroot -solid '#282828'
xrdb -merge "${XDG_CONFIG_HOME}"/Xresources

exec dwm
