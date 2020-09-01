" core
set clipboard=unnamed,unnamedplus
set confirm
set mouse=ar
set nrformats=alpha,octal,hex,bin
set omnifunc=syntaxcomplete#Complete
set splitbelow splitright
set timeoutlen=500 updatetime=500
set undofile

autocmd BufEnter * if !empty(@%) && empty(&buftype) | execute 'cd ' expand('%:h') | endif
autocmd BufReadPost * execute "normal! g'\""

noremap <Space> <Nop>
noremap s <Nop>
nnoremap Y y$
autocmd FileType qf nnoremap <buffer> <Esc> <C-W>c

nnoremap <Space>l <Cmd>lopen<CR>
nnoremap <Space>q <Cmd>copen<CR>

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
