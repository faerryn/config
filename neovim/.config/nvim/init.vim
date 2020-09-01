let s:guards = {}
function s:guarded_source(file)
    if !exists("s:guards['" . a:file . "']")
	execute 'source' a:file
	let s:guards[a:file] = 1
    endif
endfunction

execute 'augroup Personal'
autocmd!

let s:faevim_d=expand('$XDG_CONFIG_HOME/faevim')
let s:plugged_d=fnamemodify($MYVIMRC, ':h') . '/plugged'

call s:guarded_source(s:faevim_d . '/core.vim')

call s:guarded_source(s:faevim_d . '/configs/vim-plug.vim')
call plug#begin(s:plugged_d)
call s:guarded_source(s:faevim_d . '/list.vim')
call plug#end()
if !isdirectory(s:plugged_d)
    PlugInstall
endif

for s:config in split(glob(s:faevim_d . '/configs/*.vim'), '\n')
    call s:guarded_source(s:config)
endfor

execute 'augroup END'
