set hidden
set clipboard+=unnamedplus
set mouse=ar

set timeoutlen=500
set updatetime=500

set undofile

let g:mapleader=' '

set number relativenumber
set signcolumn=yes

set spell spellcapcheck=

set laststatus=2 showtabline=2
set noshowmode noshowcmd

set noequalalways
set splitbelow splitright

set linebreak wrap

set confirm
set fileformats=unix
set foldlevelstart=99
set inccommand=nosplit
set iskeyword=a-z,A-Z,48-57,_,-
set lazyredraw
set nrformats=alpha,octal,hex,bin

set termguicolors

if executable('rg')
	let &grepprg = 'rg --hidden --vimgrep'
	set grepformat=%f:%l:%c:%m
endif

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

nnoremap Y y$

augroup Personal
	autocmd!
augroup END

autocmd Personal FileType minpacprgs,qf nnoremap <silent> <buffer> <Esc> <C-W>c

autocmd Personal BufReadPost * call cursor(line("'\""), col("'\""))

let s:config_d = expand('<sfile>:p:h')

function s:load_modules_packages() abort
	if !exists('g:loaded_minpac')
		packadd minpac
		call minpac#init({
					\'dir': stdpath('data').'/site',
					\'progress_open': 'none',
					\'status_open': 'none',
					\'status_auto': v:false,
					\'confirm': v:false,
					\})
		call minpac#add('k-takata/minpac', {'type': 'opt'})
	endif

	for s:packages_f in split(glob(s:config_d.'/modules/*/packages.vim'), '\n')
		execute 'source' s:packages_f
	endfor
endfunction

function s:load_modules_config() abort
	for s:config_f in split(glob(s:config_d.'/modules/*/config.vim'), '\n')
		execute 'source' s:config_f
	endfor
endfunction

function s:SID()
	return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfun
let s:sid = s:SID()

function s:reload_configs(...) abort
	call s:load_modules_config()
	tabdo windo edit
endfunction

function s:reload_packages() abort
	call s:load_modules_packages()
	call minpac#clean()
	call minpac#update('', {'do': 'call <SNR>'.s:sid.'_reload_configs'})
endfunction

command! -bar ReloadConfigs call s:reload_packages()
command! -bar ReloadPackages call s:reload_packages()

if !isdirectory(stdpath('data').'/site/pack/minpac')
	call system('git clone --depth 1 https://github.com/k-takata/minpac.git '.stdpath('data').'/site/pack/minpac/opt/minpac')
	autocmd Personal VimEnter * call s:reload_packages()
else
	call s:load_modules_config()
endif
