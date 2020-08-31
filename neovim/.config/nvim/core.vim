" core
set clipboard=unnamed,unnamedplus
set confirm
set hidden
set lazyredraw
set mouse=ar
set nrformats=alpha,octal,hex,bin
set omnifunc=syntaxcomplete#Complete
set spell spellcapcheck=
set splitbelow splitright
set timeoutlen=500
set undofile
set updatetime=50

let &grepprg='rg --vimgrep'
let g:mapleader=' '

noremap <Leader> <Nop>
noremap s <Nop>

nnoremap Y y$

nnoremap <Leader>l <Cmd>lopen<CR>
nnoremap <Leader>q <Cmd>copen<CR>

autocmd FileType qf nnoremap <buffer> <Esc> <C-W>c

" aesthetics
set cursorline cursorcolumn colorcolumn=80
set inccommand=nosplit
set noequalalways
set noruler
set noshowmode
set nowrap linebreak
set number relativenumber signcolumn=yes "number
set showtabline=0
set softtabstop=4 shiftwidth=4
set termguicolors
