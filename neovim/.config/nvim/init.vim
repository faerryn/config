let s:nvim_d=stdpath('config')
let s:plugged_d=s:nvim_d . '/plugged'

let s:guards = {}
function s:guarded_source(file)
    if filereadable(a:file) && !exists("s:guards['" . a:file . "']")
	execute 'source' a:file
	let s:guards[a:file] = 1
    endif
endfunction

call s:guarded_source(s:nvim_d . '/core.vim')

call s:guarded_source(s:nvim_d . '/configs/vim-plug.vim')
execute 'set runtimepath+=' . s:nvim_d . '/vim-plug'
call plug#begin(s:plugged_d)
call s:guarded_source(s:nvim_d . '/list.vim')
call plug#end()

if !isdirectory(s:plugged_d)
    PlugInstall
endif

for s:config in split(glob(s:nvim_d . '/configs/*.vim'), '\n')
    call s:guarded_source(s:config)
endfor
