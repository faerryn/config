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
echo "${WALLPAPER}" | entr -n hsetroot -solid '#282828' -cover "${WALLPAPER}" &

exec dwm
