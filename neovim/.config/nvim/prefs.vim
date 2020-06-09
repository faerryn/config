" Autosourcing
augroup SourceVimConfig
	execute 'autocmd! BufWritePost ' . expand('<sfile>')
				\ . ' source ' . expand('<sfile>')
augroup END

let g:mapleader=' '
set cindent
set cursorline cursorcolumn
set foldmethod=syntax foldlevelstart=20
set hidden
set ignorecase smartcase
set lazyredraw
set mouse=ar
set nowrap
set number relativenumber
set omnifunc=syntaxcomplete#Complete
set signcolumn=yes
set splitbelow splitright
set tabstop=4 softtabstop=4 shiftwidth=4
set termguicolors
set timeoutlen=250
set undofile
set updatetime=250
set wildmode=list:longest,full

nnoremap <silent> <leader>c :copen<cr>
nnoremap <silent> <leader>d :bdelete<cr>
nnoremap <silent> <leader>l :lopen<cr>
nnoremap <silent> <leader>t :tabedit<cr>
nnoremap <silent> <leader>w :write<cr>
nnoremap <silent> [b :bprevious<cr>
nnoremap <silent> ]b :bnext<cr>

augroup QuickfixSettings
	autocmd!
	autocmd Filetype qf nnoremap <silent> <buffer> <esc> <c-w>q
augroup END
