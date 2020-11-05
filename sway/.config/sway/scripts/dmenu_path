#!/bin/sh
mkdir -p ${XDG_CACHE_HOME}
CACHE=${XDG_CACHE_HOME}/dmenu_path

gen_path () {
	echo ${PATH} | tr ':' '\n' | xargs readlink -f | sort | uniq | xargs -I{} fd . {} -tf -d1 -L -X echo {/} | tr ' ' '\n' | sort
}

if test -f ${CACHE}; then
	cat ${CACHE}
	TMP=$(mktemp /tmp/dmenu_path_XXX)
	gen_path > ${TMP}
	grep -vxFf ${CACHE} ${TMP}
	cp ${TMP} ${CACHE}
	rm ${TMP}
else
	gen_path | tee ${CACHE}
fi
