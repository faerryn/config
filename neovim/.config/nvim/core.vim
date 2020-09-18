let mapleader = ' '
set clipboard+=unnamedplus
set confirm
set foldlevelstart=99
set hidden
set inccommand=nosplit
set iskeyword=a-z,A-Z,48-57,_,-
set lazyredraw
set mouse=ar
set nrformats=alpha,octal,hex,bin
set omnifunc=syntaxcomplete#Complete
set spell spellcapcheck=
set timeoutlen=500 updatetime=500
set undofile

let &shadafile = expand('$XDG_CACHE_HOME/nvim/shada/main.shada')
set directory=$XDG_CACHE_HOME/nvim/swap
set undodir=$XDG_CACHE_HOME/nvim/undo

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line('$') | execute "normal! g'\"" | endif

set laststatus=2 showtabline=2
set noequalalways
set noshowmode noshowcmd
set number relativenumber signcolumn=number
set splitbelow splitright
set wrap linebreak

set background=dark
set termguicolors
doautocmd ColorScheme

autocmd TextYankPost * lua vim.highlight.on_yank{ timeout=500 }
