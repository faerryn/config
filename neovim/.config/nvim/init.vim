let s:plugin_list_f=stdpath('config') . '/plugin_list.vim'
let s:configs_d=stdpath('config') . '/configs'
let s:plug_vim=stdpath('data') . '/site/autoload/plug.vim'
let s:plugged_d=stdpath('data') . '/plugged'
let s:plug_doc = stdpath('data') . '/site/doc/plug.txt'

function! s:enhanced_source(file) abort
	let l:resolved_file=resolve(a:file)
	execute 'augroup Personal_' . substitute(l:resolved_file, '\/\|\.', '_', 'g')
	autocmd!
	execute 'source' a:file
	execute 'autocmd BufWritePost' l:resolved_file 'source' l:resolved_file
	execute 'augroup END'
endfunction

function! s:load_list() abort
	call plug#begin(s:plugged_d)
	execute 'source' s:plugin_list_f
	call plug#end()
	execute 'helptag' fnamemodify(s:plug_doc, ':h')
endfunction

augroup PersonalInit
	autocmd!
	execute 'autocmd BufWritePost' resolve($MYVIMRC) 'source $MYVIMRC'
augroup END

""" CORE
call s:enhanced_source(stdpath('config') . '/core.vim')

""" VIM-PLUG
let s:plug_vim=stdpath('data') . '/site/autoload/plug.vim'
let s:plug_doc = stdpath('data') . '/site/doc/plug.txt'
if !filereadable(s:plug_vim)
	execute 'silent !curl -fLo "' . s:plug_vim . '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	execute 'source' s:plug_vim
	execute 'silent !curl -fLo "' . s:plug_doc . '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/doc/plug.txt'
endif

""" PLUG_LIST
call s:load_list()
execute 'autocmd PersonalInit BufWritePost' resolve(s:plugin_list_f) 'source call s:load_list()'

if !isdirectory(s:plugged_d)
	call s:enhanced_source(s:configs_d . '/vim-plug.vim')
	PlugInstall
endif

""" CONFIGS
for s:config_f in split(glob(s:configs_d . '/*.vim'), '\n')
	call s:enhanced_source(s:config_f)
endfor
