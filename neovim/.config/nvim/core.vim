" core
set clipboard+=unnamedplus
set confirm
set hidden
set mouse=ar
set nrformats=alpha,octal,hex,bin
set omnifunc=syntaxcomplete#Complete
set spell spellcapcheck=
set splitbelow splitright
set tabstop=4 shiftwidth=4 noexpandtab
set timeoutlen=500 updatetime=500
set undofile

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") < line('$') | execute "normal! g'\"" | endif

let mapleader=' '

nnoremap Y y$
noremap <Leader> <Nop>
noremap s <Nop>

" aesthetics
if has('nvim') | set inccommand=nosplit | endif
set cursorline cursorcolumn colorcolumn=80
set lazyredraw
set noequalalways
set noruler
set noshowmode
set number relativenumber signcolumn=number
set showtabline=0
set wrap linebreak
