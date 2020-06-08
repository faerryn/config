augroup SourceInitVim
	autocmd!
	execute "autocmd BufWritePost $MYVIMRC source $MYVIMRC"
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
set wildmode=longest,list,full

nnoremap <silent> <leader>d :bdelete<cr>
nnoremap <silent> <leader>t :tabedit<cr>
nnoremap <silent> <leader>w :write<cr>

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
Plug 'vimwiki/vimwiki'

" Language support
Plug 'bfrg/vim-cpp-modern', { 'for': ['cpp',  'vimwiki'] }
Plug 'rust-lang/rust.vim' , { 'for': ['rust', 'vimwiki'] }
Plug 'ziglang/zig.vim'    , { 'for': ['zig',  'vimwiki'] }

" Aesthetics
Plug 'machakann/vim-highlightedyank'
Plug 'itchyny/lightline.vim'

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

if s:vim_plug_ready

	let s:rightbar_width = float2nr(&columns * 0.4)
	let s:random_colorschemes = ['gruvbox', 'nord', 'onehalfdark']

	nnoremap <silent> <leader>f :Files<cr>
	execute "nnoremap <silent> <leader>g :Git<cr><c-w>L<cr>:vertical resize " . s:rightbar_width . "<cr>"
	nnoremap <silent> <leader>u :UndotreeToggle<cr>

	let g:highlightedyank_highlight_duration = 250
	runtime macros/sandwich/keymap/surround.vim

	let g:gruvbox_italic = 1
	if !exists('g:colors_name')
		execute "colorscheme " . s:random_colorschemes[
					\ system("echo $RANDOM") % len(s:random_colorschemes)
					\ ]
	endif

	let g:rustfmt_autosave = 1
	let g:zig_fmt_autosave = 1
	if executable("clang-format")
		augroup AutoClangFormat
			autocmd!
			autocmd BufwritePre *.c,*.cpp %!clang-format
		augroup END
	endif

	let g:undotree_HelpLine           = 0
	let g:undotree_SetFocusWhenToggle = 1
    let g:undotree_CustomUndotreeCmd  = 'belowright vertical ' . s:rightbar_width . ' new'
    let g:undotree_CustomDiffpanelCmd = 'belowright 8 new'
	augroup UndoTreeShortcut
		autocmd!
		autocmd Filetype undotree nnoremap <silent> <buffer> <esc> :UndotreeToggle<cr>
	augroup END

	function s:fugitive_settings()
		nnoremap <silent> <buffer> <esc> <c-w>q
	endfunction
	augroup FugitiveSettings
		autocmd!
		autocmd Filetype fugitive call s:fugitive_settings()
	augroup END

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
	augroup VimwikiSettings
		autocmd!
		autocmd FileType vimwiki call s:vimwiki_settings()
	augroup END
	
	let g:fzf_layout = { 'right': s:rightbar_width }
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
	command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, <bang>0)
	command! -bang Buffers call fzf#vim#buffers(<bang>0)

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

		lua require'nvim_lsp'.clangd.setup{}
		lua require'nvim_lsp'.rls.setup{}
		function s:lsp_settings()
			nnoremap <silent> <buffer> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
			nnoremap <silent> <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
			nnoremap <silent> <buffer> K     <cmd>lua vim.lsp.buf.hover()<CR>
			nnoremap <silent> <buffer> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
			nnoremap <silent> <buffer> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
			nnoremap <silent> <buffer> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
			nnoremap <silent> <buffer> gr    <cmd>lua vim.lsp.buf.references()<CR>
			nnoremap <silent> <buffer> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
			nnoremap <silent> <buffer> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
			setlocal omnifunc=v:lua.vim.lsp.omnifunc
		endfunction
		augroup LspSettings
			autocmd!
			autocmd Filetype cpp,rust call s:lsp_settings()
		augroup END

	else

		let g:syntastic_always_populate_loc_list = 1
		let g:syntastic_auto_loc_list            = 1
		let g:syntastic_check_on_open            = 1

	endif

endif
