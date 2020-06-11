let g:mapleader=' '
set colorcolumn=80
set cursorline cursorcolumn
set foldmethod=syntax foldlevelstart=20
set hidden
set ignorecase smartcase
set lazyredraw
set list listchars=tab:\|\ ,trail:-,nbsp:+
set mouse=ar
set nowrap
set number relativenumber
set omnifunc=syntaxcomplete#Complete
set signcolumn=yes
set splitbelow splitright
set tabstop=4 shiftwidth=4
set termguicolors
set timeoutlen=250
set undofile
set updatetime=250

nnoremap <silent> <leader>l <cmd>lopen<cr>
nnoremap <silent> <leader>q <cmd>copen<cr>

nnoremap / /\v
nnoremap ? ?\v

nnoremap <silent> <leader>g <cmd>G<cr>
nnoremap <silent> <leader>f <cmd>Files<cr>

if !exists('g:colors_name')
	let g:gruvbox_italic = 1
	let g:gruvbox_italicize_strings = 1
	let g:gruvbox_contrast_dark = 'soft'
	colorscheme gruvbox
endif

augroup AutoSourceInitVim
	autocmd!
	execute 'autocmd BufWritePost $MYVIMRC,' . resolve($MYVIMRC)
				\ . ' source $MYVIMRC'
augroup END

command! Resource source $MYVIMRC

augroup EscapeToQuit
	autocmd!
	autocmd FileType qf,help,dirvish,fugitive,gitcommit
				\ nnoremap <silent> <buffer> <esc> <cmd>bdelete<cr>
	autocmd FileType fzf tnoremap <silent> <buffer> <c-w>q <esc>
augroup END

augroup ProseSettings
	autocmd!
	autocmd FileType vimwiki,gitcommit setlocal wrap linebreak spell
augroup END

let g:rustfmt_autosave = 1
let g:zig_fmt_autosave = 1

packadd vim-sandwich
runtime macros/sandwich/keymap/surround.vim

if isdirectory(glob('~/.fzf'))
	set runtimepath^=~/.fzf
endif
let g:fzf_colors = { 
			\ 'fg'     : ['fg', 'Normal'],
			\ 'bg'     : ['bg', 'Normal'],
			\ 'hl'     : ['fg', 'Comment'],
			\ 'fg+'    : ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
			\ 'bg+'    : ['bg', 'CursorLine', 'CursorColumn'],
			\ 'hl+'    : ['fg', 'Statement'],
			\ 'info'   : ['fg', 'PreProc'],
			\ 'border' : ['fg', 'Ignore'],
			\ 'prompt' : ['fg', 'Conditional'],
			\ 'pointer': ['fg', 'Exception'],
			\ 'marker' : ['fg', 'Keyword'],
			\ 'spinner': ['fg', 'Label'],
			\ 'header' : ['fg', 'Comment']
			\ }
command! -bang -nargs=? -complete=dir Files
			\ call fzf#vim#files(<q-args>, <bang>0)
command! -bang Buffers call fzf#vim#buffers(<bang>0)

let g:lightline = { 
			\ 'active': {
			\	'left': [
			\ 		[ 'mode', 'paste' ],
			\ 		[ 'gitbranch', 'readonly', 'filename', 'modified' ]
			\ 	]
			\ },
			\ 'component_function': { 'gitbranch': 'FugitiveHead' },
			\ }
function! s:lightline_settings()
	if exists('g:colors_name')
		let g:lightline.colorscheme = g:colors_name
	endif
	if exists('*lightline#enable()')
		call lightline#enable()
	endif
endfunction
augroup LightlineSettings
	autocmd!
	autocmd ColorScheme * call s:lightline_settings()
augroup END
call s:lightline_settings()

if has('nvim-0.5.0')

	packadd nvim-lsp
	lua require'nvim_lsp'.clangd.setup{}
	lua require'nvim_lsp'.rls.setup{}
	function s:lsp_settings()
		nnoremap <silent> <buffer> gd
					\ <cmd>lua vim.lsp.buf.declaration()<CR>
		nnoremap <silent> <buffer> <c-]>
					\ <cmd>lua vim.lsp.buf.definition()<CR>
		nnoremap <silent> <buffer> K
					\ <cmd>lua vim.lsp.buf.hover()<CR>
		nnoremap <silent> <buffer> gD
					\ <cmd>lua vim.lsp.buf.implementation()<CR>
		nnoremap <silent> <buffer> <c-k>
					\ <cmd>lua vim.lsp.buf.signature_help()<CR>
		nnoremap <silent> <buffer> 1gD
					\ <cmd>lua vim.lsp.buf.type_definition()<CR>
		nnoremap <silent> <buffer> gr
					\ <cmd>lua vim.lsp.buf.references()<CR>
		nnoremap <silent> <buffer> g0
					\ <cmd>lua vim.lsp.buf.document_symbol()<CR>
		nnoremap <silent> <buffer> gW
					\ <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
		setlocal omnifunc=v:lua.vim.lsp.omnifunc
	endfunction
	augroup LspSettings
		autocmd!
		autocmd FileType cpp,rust call s:lsp_settings()
	augroup END

	augroup TextYankHighlight
		autocmd!
		autocmd TextYankPost * silent!
					\ lua require'vim.highlight'.on_yank('Substitute', 250)
	augroup END

else

	packadd syntastic
	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_check_on_open            = 1

	packadd vim-highlightedyank
	let g:highlightedyank_highlight_duration = 250

endif

" Allow vim to find help pages for plugins
silent! helptags ALL
