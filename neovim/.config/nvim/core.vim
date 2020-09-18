let mapleader = ' '
set background=dark
set clipboard+=unnamedplus
set confirm
set foldlevelstart=99
set hidden
set inccommand=nosplit
set iskeyword=a-z,A-Z,48-57,_,-
set laststatus=2 showtabline=2
set lazyredraw
set mouse=ar
set noequalalways
set noshowmode
set nrformats=alpha,octal,hex,bin
set number relativenumber signcolumn=number
set omnifunc=syntaxcomplete#Complete
set spell spellcapcheck=
set splitbelow splitright
set termguicolors
set timeoutlen=500 updatetime=500
set undofile
set wrap linebreak

let &shadafile = expand('$XDG_CACHE_HOME/nvim/shada/main.shada')
set directory=$XDG_CACHE_HOME/nvim/swap
set undodir=$XDG_CACHE_HOME/nvim/undo

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line('$') | execute "normal! g'\"" | endif
autocmd TextYankPost * lua vim.highlight.on_yank{ timeout=500 }
