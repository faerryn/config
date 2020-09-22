set iskeyword=a-z,A-Z,48-57,_,-
set nrformats=alpha,octal,hex,bin
set omnifunc=syntaxcomplete#Complete
set spell spellcapcheck=
set undofile

autocmd BufReadPost * lua pcall(vim.api.nvim_win_set_cursor, 0, vim.api.nvim_buf_get_mark(0, '"'))

set number relativenumber signcolumn=number
set wrap linebreak

autocmd TextYankPost * lua vim.highlight.on_yank{timeout=500}
