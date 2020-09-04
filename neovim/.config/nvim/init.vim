let s:core_f=stdpath('config') . '/core.vim'
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

let s:plugged_d=stdpath('data') . '/plugged'
let s:list_f=stdpath('config') . '/list.vim'

function! s:load_list() abort
	call plug#begin(s:plugged_d)
	execute 'source' s:list_f
	call plug#end()
endfunction

call s:load_list()
execute 'autocmd BufWritePost' resolve(s:list_f) 'call s:load_list()'

if !isdirectory(s:plugged_d)
	execute 'source' stdpath('config') . '/configs/vim-plug.vim'
	PlugInstall
endif

for s:config_f in split(glob(stdpath('config') . '/configs/*.vim'), '\n')
	execute 'source' s:config_f
	execute 'autocmd BufWritePost' resolve(s:config_f) 'source' s:config_f
endfor
