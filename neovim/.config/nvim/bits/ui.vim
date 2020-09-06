set clipboard+=unnamedplus
set confirm
set cursorline cursorcolumn colorcolumn=80
set inccommand=nosplit
set lazyredraw
set mouse=ar
set noequalalways
set noruler
set noshowmode
set nrformats=alpha,octal,hex,bin
set number relativenumber signcolumn=number
set omnifunc=syntaxcomplete#Complete
set showtabline=0
set splitbelow splitright
set tabstop=4 shiftwidth=4 noexpandtab
set wrap linebreak

autocmd TextYankPost * lua vim.highlight.on_yank{timeout=500}
