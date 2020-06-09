" Autosourcing
augroup SourceVimConfig
	execute 'autocmd! BufWritePost ' . expand('<sfile>')
				\ . ' source ' . expand('<sfile>')
augroup END

call plug#begin(stdpath('data') . '/plugged')

" Essential editing improvements
Plug 'machakann/vim-sandwich'
Plug 'tommcdo/vim-lion'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'

" Excellent additional features
Plug 'justinmk/vim-dirvish'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-signify'
Plug 'pbrisbin/vim-mkdir'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'

" Language support
Plug 'bfrg/vim-cpp-modern', { 'for': ['cpp',  'vimwiki'] }
Plug 'rust-lang/rust.vim' , { 'for': ['rust', 'vimwiki'] }
Plug 'ziglang/zig.vim'    , { 'for': ['zig',  'vimwiki'] }

" Aesthetics
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'

" Colorschemes
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" UI with FZF
Plug 'junegunn/fzf.vim'
if !isdirectory('~/.fzf')
	Plug '~/.fzf'
endif

" Better language support
if has('nvim-0.5.0')
	Plug 'neovim/nvim-lsp'
else
	Plug 'vim-syntastic/syntastic'
endif

call plug#end()
