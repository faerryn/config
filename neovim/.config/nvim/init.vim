augroup SourceInitVim
	autocmd!
	execute "autocmd BufWritePost $MYVIMRC source $MYVIMRC"
augroup END

let g:mapleader=' '
set foldmethod=syntax foldlevelstart=20
set hidden
set ignorecase        smartcase
set lazyredraw
set mouse=ar
set nowrap
set number            relativenumber
set omnifunc=syntaxcomplete#Complete
set signcolumn=yes
set smartindent
set splitbelow        splitright
set termguicolors
set timeoutlen=250
set undofile
set updatetime=250

nnoremap <leader>f :Files<cr>
nnoremap <leader>g :Git<cr>
nnoremap <leader>u :UndotreeToggle<cr>
nnoremap <leader>w :write<cr>

let s:vim_plug_ready = v:true
if empty(glob(stdpath('data') . '/site/autoload/plug.vim'))
	execute "!curl -fLo " . stdpath('data') . "/site/autoload/plug.vim --create-dirs"
				\ . " https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
	augroup VimPlugInstall
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	augroup END
	let s:vim_plug_ready = v:false
endif

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
Plug 'vim-syntastic/syntastic'
Plug 'vimwiki/vimwiki'

" Language support
Plug 'bfrg/vim-cpp-modern', { 'for': ['cpp',  'vimwiki'] }
Plug 'rust-lang/rust.vim' , { 'for': ['rust', 'vimwiki'] }
Plug 'ziglang/zig.vim'    , { 'for': ['zig',  'vimwiki'] }

" Aesthetics
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'

" UI with FZF
Plug 'junegunn/fzf.vim'
if !isdirectory('~/.fzf')
	Plug '~/.fzf'
endif

" LSP
if has('nvim-0.5.0')
	Plug 'neovim/nvim-lsp'
endif

" Snippets with snipmate
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'tomtom/tlib_vim'

call plug#end()

if s:vim_plug_ready

	colorscheme nord
	let g:highlightedyank_highlight_duration = 250
	let g:rustfmt_autosave = 1
	let g:zig_fmt_autosave = 1
	runtime macros/sandwich/keymap/surround.vim

	if executable("clang-format")
		augroup AutoClangFormat
			autocmd!
			autocmd BufwritePre *.c,*.cpp %!clang-format
		augroup END
	endif

	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_auto_loc_list            = 1
	let g:syntastic_check_on_open            = 1
	let g:syntastic_check_on_wq              = 1

	let g:undotree_HelpLine           = 0
	let g:undotree_SetFocusWhenToggle = 1
	let g:undotree_WindowLayout       = 3

	let g:loaded_netrw       = 1
	let g:loaded_netrwPlugin = 1
	command! -nargs=? -complete=dir Explore Dirvish <args>
	command! -nargs=? -complete=dir Sexplore rightbelow split | Dirvish <args>
	command! -nargs=? -complete=dir Vexplore leftabove vsplit | Dirvish <args>

	function! s:vimwiki_settings()
		setlocal wrap linebreak spell
		nnoremap <silent> <buffer> j gj
		vnoremap <silent> <buffer> j gj
		nnoremap <silent> <buffer> k gk
		vnoremap <silent> <buffer> k gk
		nnoremap <silent> <buffer> 0 g0
		vnoremap <silent> <buffer> 0 g0
		nnoremap <silent> <buffer> $ g$
		vnoremap <silent> <buffer> $ g$
	endfunction
	augroup Vimwiki
		autocmd!
		autocmd FileType vimwiki call s:vimwiki_settings()
	augroup END
	
	let g:fzf_colors = { 
				\ 'fg':      ['fg', 'Normal'],
				\ 'bg':      ['bg', 'Normal'],
				\ 'hl':      ['fg', 'Comment'],
				\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
				\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
				\ 'hl+':     ['fg', 'Statement'],
				\ 'info':    ['fg', 'PreProc'],
				\ 'border':  ['fg', 'Ignore'],
				\ 'prompt':  ['fg', 'Conditional'],
				\ 'pointer': ['fg', 'Exception'],
				\ 'marker':  ['fg', 'Keyword'],
				\ 'spinner': ['fg', 'Label'],
				\ 'header':  ['fg', 'Comment']
				\ }

	let g:lightline = { 
				\ 'active': {
				\	'left': [
				\ 		[ 'mode', 'paste' ],
				\ 		[ 'gitbranch', 'readonly', 'filename', 'modified' ]
				\ 	]
				\ },
				\ 'component_function': { 'gitbranch': 'FugitiveHead' },
				\ 'separator': { 'left': '', 'right': '' },
				\ 'subseparator': { 'left': '', 'right': '' },
				\ }
	function! s:update_lightline()
		let g:lightline.colorscheme = g:colors_name
		call g:lightline#enable()
	endfunction
	call s:update_lightline()
	augroup UpdateLightline
		autocmd!
		autocmd ColorScheme * call s:update_lightline()
	augroup END

	if has('nvim-0.5.0')
lua << EOF
nvim_lsp = require'nvim_lsp'
nvim_lsp.clangd.setup{}
nvim_lsp.rls.setup{}
EOF
	endif

endif
