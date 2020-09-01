" core
set clipboard=unnamed,unnamedplus
set confirm
set lazyredraw
set mouse=ar
set nrformats=alpha,octal,hex,bin
set omnifunc=syntaxcomplete#Complete
set spell spellcapcheck=
set splitbelow splitright
set timeoutlen=500
set undofile
set updatetime=500

autocmd BufEnter * if len(expand('%')) > 0 | execute 'cd ' expand('%:h') | endif
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

noremap <Space> <Nop>
noremap s <Nop>
nnoremap Y y$
autocmd FileType qf nnoremap <buffer> <Esc> <C-W>c
silent! execute 'mkspell! ' g:personal_vim_d . '/spell/*.add'

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
set softtabstop=4 shiftwidth=4

autocmd TextYankPost * lua vim.highlight.on_yank{timeout=500}
