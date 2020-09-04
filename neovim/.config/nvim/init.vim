let s:list_f=stdpath('config') . '/list.vim'
let s:configs_d=stdpath('config') . '/configs'
let s:plugged_d=stdpath('data') . '/plugged'

function! s:enhanced_source(file) abort
	let l:resolved_file=resolve(a:file)
	execute 'augroup Personal_' . substitute(l:resolved_file, '\/\|\.', '_', 'g')
	autocmd!
	execute 'source' a:file
	execute 'autocmd BufWritePost' resolve(l:resolved_file) 'source' l:resolved_file
	execute 'augroup END'
endfunction

function! s:load_list() abort
	call plug#begin(s:plugged_d)
	call s:enhanced_source(s:list_f)
	call plug#end()
endfunction

augroup PersonalInit
	autocmd!
	execute 'autocmd BufWritePost' resolve($MYVIMRC) 'source $MYVIMRC'
augroup END

""" CORE
call s:enhanced_source(stdpath('config') . '/core.vim')

""" VIM-PLUG
let s:plug_vim=stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(s:plug_vim)
	execute 'silent !curl -fLo "' . s:plug_vim . '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	execute 'source' s:plug_vim
	let s:plug_doc = stdpath('data') . '/site/doc/plug.txt'
	execute 'silent !curl -fLo "' . s:plug_doc . '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/doc/plug.txt'
	execut 'helptag' fnamemodify(s:plug_doc, ':h')
endif

""" PLUG_LIST
call s:load_list()

if !isdirectory(s:plugged_d)
	call s:enhanced_source(s:configs_d . '/vim-plug.vim')
	PlugInstall
endif

""" CONFIGS
for s:config_f in split(glob(s:configs_d . '/*.vim'), '\n')
	call s:enhanced_source(s:config_f)
endfor
