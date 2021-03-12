#!/bin/sh

set -euf
unset TERM

WALLPAPER="${XDG_CONFIG_HOME}"/wallpaper

export _JAVA_AWT_WM_NONREPARENTING=1
export MOZ_X11_EGL=1
export SDL_VIDEODRIVER=x11

slstatus &
picom &
redshift &
xrdb -merge "${XDG_CONFIG_HOME}"/Xresources
hsetroot -cover "${WALLPAPER}" || hsetroot -solid '#282828'

exec dwm
