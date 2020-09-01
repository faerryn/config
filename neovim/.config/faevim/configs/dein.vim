command! DeinUpdate call dein#update()
command! DeinClean for s:plugin in  dein#check_clean() | call delete(s:plugin, 'rf') | endfor
