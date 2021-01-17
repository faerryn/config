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

if has('win32')
	set shell=cmd.exe
endif

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

nnoremap Y y$

autocmd Personal FileType minpacprgs,qf nnoremap <silent> <buffer> <Esc> <C-W>c
autocmd Personal BufReadPost * call cursor(line("'\""), col("'\""))

packadd FixCursorHold.nvim

packadd vim-mkdir

packadd vim-repeat
packadd vim-visualrepeat

packadd vim-wordmotion

packadd readline.vim
packadd vim-qf
