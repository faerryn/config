#!/bin/sh
unset TERM
export _JAVA_AWT_WM_NONREPARENTING=1
export MOZ_X11_EGL=1
export SDL_VIDEODRIVER=x11

slstatus &
picom &
redshift &
xrdb -merge "${XDG_CONFIG_HOME}"/Xresources
hsetroot -solid '#282828' -cover "${XDG_CONFIG_HOME}"/wallpaper

exec dwm
