let g:mapleader=' '
set cindent
set colorcolumn=80
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
set spell
set splitbelow splitright
set tabstop=4 softtabstop=4 shiftwidth=4
set termguicolors
set timeoutlen=250
set undofile
set updatetime=250

nnoremap <silent> <leader>l :lopen<cr>
nnoremap <silent> <leader>q :copen<cr>

augroup QuickfixSettings
	autocmd!
	autocmd FileType qf nnoremap <silent> <buffer> <esc> <c-w>q
augroup END

augroup FormatOnWrite
	autocmd!
	if executable("clang-format")
		autocmd BufWritePre *.c,*.cpp %!clang-format
	endif
augroup END

packadd fzf.vim
packadd lightline.vim
packadd rust.vim
packadd targets.vim
packadd tcomment_vim
packadd undotree
packadd vim-cpp-modern
packadd vim-dirvish
packadd vim-dispatch
packadd vim-eunuch
packadd vim-fugitive
packadd vim-highlightedyank
packadd vim-lion
packadd vim-mkdir
packadd vim-repeat
packadd vim-sandwich
packadd vim-signify
packadd vim-unimpaired
packadd vimwiki
packadd zig.vim
