execute 'augroup Personal'
autocmd!

let s:faevim_d=expand('$XDG_CONFIG_HOME/faevim')

execute 'source' s:faevim_d . '/core.vim'

let s:dein_d=fnamemodify($MYVIMRC, ':h') . '/dein.vim'
let s:dein_cache_d=fnamemodify($MYVIMRC, ':h') . '/dein_cache'

let &runtimepath.=',' . s:dein_d

if dein#load_state(s:dein_cache_d)
    call dein#begin(s:dein_cache_d)
    call dein#add(s:dein_d)
    execute 'source' s:faevim_d . '/list.vim'
    call dein#end()
    call dein#save_state()
endif
if !isdirectory(s:dein_cache_d . '/repos')
    call dein#install()
endif

for s:config in split(glob(s:faevim_d . '/configs/*.vim'), '\n')
    execute 'source' s:config
endfor

execute 'augroup END'
