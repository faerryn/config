let s:core_f=stdpath('config') . '/core.vim'
let s:list_f=stdpath('config') . '/list.vim'
let s:configs_d=stdpath('config') . '/configs'
let s:plugged_d=stdpath('data') . '/plugged'

execute 'source' s:core_f
execute 'autocmd BufWritePost' resolve(s:core_f) 'source' s:core_f

let s:plug_vim=stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(s:plug_vim)
	execute 'silent !curl -fLo "' . s:plug_vim . '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	execute 'source' s:plug_vim
	let s:plug_doc = stdpath('data') . '/site/doc/plug.txt'
	execute 'silent !curl -fLo "' . s:plug_doc . '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/doc/plug.txt'
	execut 'helptag' fnamemodify(s:plug_doc, ':h')
endif

function! s:load_list() abort
	call plug#begin(s:plugged_d)
	execute 'source' s:list_f
	call plug#end()
endfunction

call s:load_list()
execute 'autocmd BufWritePost' resolve(s:list_f) 'call s:load_list()'

if !isdirectory(s:plugged_d)
	execute 'source' s:configs_d . '/vim-plug.vim'
	PlugInstall
endif

for s:config_f in split(glob(s:configs_d . '/*.vim'), '\n')
	execute 'source' s:config_f
	execute 'autocmd BufWritePost' resolve(s:config_f) 'source' s:config_f
endfor
