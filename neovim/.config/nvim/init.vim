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
set noshowcmd noshowmode

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
set omnifunc=syntaxcomplete#Complete

if executable('rg')
	let &grepprg = 'rg --hidden --vimgrep'
	set grepformat=%f:%l:%c:%m
endif

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

nnoremap Y y$

nnoremap <silent> ]a <cmd>next<CR>
nnoremap <silent> [a <cmd>previous<CR>
nnoremap <silent> ]A <cmd>last<CR>
nnoremap <silent> [A <cmd>first<CR>

nnoremap <silent> ]b <cmd>bnext<CR>
nnoremap <silent> [b <cmd>bprevious<CR>
nnoremap <silent> ]B <cmd>blast<CR>
nnoremap <silent> [B <cmd>bfirst<CR>

nnoremap <silent> <Leader>l <cmd>lopen<CR>
nnoremap <silent> <Leader>q <cmd>copen<CR>

nnoremap <silent> ]q <cmd>cnext<CR>
nnoremap <silent> [q <cmd>cprevious<CR>
nnoremap <silent> ]Q <cmd>clast<CR>
nnoremap <silent> [Q <cmd>cfirst<CR>

nnoremap <silent> ]l <cmd>lnext<CR>
nnoremap <silent> [l <cmd>lprevious<CR>
nnoremap <silent> ]L <cmd>llast<CR>
nnoremap <silent> [L <cmd>lfirst<CR>

if !executable('git')
	finish
end

let s:config_d=expand('<sfile>:p:h')

function s:load_modules_packages() abort
	if !exists('g:loaded_minpac')
		if !isdirectory(stdpath('data').'/site/pack/minpac')
			call system('git clone https://github.com/k-takata/minpac.git '.stdpath('data').'/site/pack/minpac/opt/minpac')
		endif
		packadd minpac
		call minpac#init({'dir': stdpath('data').'/site'})
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

command! -bar LoadPackages call s:load_modules_packages()
command! -bar LoadConfig call s:load_modules_config()

call s:load_modules_config()
