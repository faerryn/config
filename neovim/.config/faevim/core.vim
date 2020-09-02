augroup Faevim
    autocmd!
augroup END

" core
set clipboard+=unnamedplus
set confirm
set hidden
set mouse=ar
set nrformats=alpha,octal,hex,bin
set omnifunc=syntaxcomplete#Complete
set splitbelow splitright
set timeoutlen=500 updatetime=500
set undofile

autocmd BufEnter * if !empty(@%) && empty(&buftype) | execute 'cd ' expand('%:h') | endif
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") < line('$') | execute "normal! g'\"" | endif

let g:mapleader=' '

nnoremap Y y$
noremap <Leader> <Nop>
noremap s <Nop>

" aesthetics
set cursorline cursorcolumn colorcolumn=80
set inccommand=nosplit
set noequalalways
set noruler
set noshowmode
set wrap linebreak
set number relativenumber signcolumn=number
set showtabline=0
set lazyredraw
set softtabstop=4 shiftwidth=4

autocmd TextYankPost * lua vim.highlight.on_yank{timeout=500}
