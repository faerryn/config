#!/bin/sh
cd $(dirname ${0})

swayidle -w timeout 300 'logout.sh lock' timeout 900 'logout.sh suspend' &
