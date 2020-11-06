#!/bin/sh
vol=$(aucatctl ${1} | cut -d= -f2)

if test ${#} -eq 2; then
	vol=$((${vol}${2}))
	if test ${vol} -gt 127; then
		vol=127
	elif test ${vol} -lt 0; then
		vol=0
	fi
	>/dev/null aucatctl ${1}=${vol}
fi

echo ${vol}
