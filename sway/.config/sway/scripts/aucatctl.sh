#/bin/sh
set -e
vol=$(($(aucatctl ${1} | cut -d'=' -f2)${2}))
test ${vol} -le 0 && vol=0
test ${vol} -gt 127 && vol=127
aucatctl ${1}=${vol}
