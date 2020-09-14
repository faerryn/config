set noequalalways
set noruler
set noshowmode
set number relativenumber signcolumn=number
set wrap linebreak

autocmd TextYankPost * lua vim.highlight.on_yank{ timeout=500 }
