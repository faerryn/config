set iskeyword=a-z,A-Z,48-57,_,-
set nrformats=alpha,octal,hex,bin
set omnifunc=syntaxcomplete#Complete
set spell spellcapcheck=
set undofile

set number relativenumber signcolumn=number
set wrap linebreak

autocmd TextYankPost * lua vim.highlight.on_yank{ timeout=500 }
