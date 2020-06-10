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

" Plugin Settings
let s:rightbar_width = 'float2nr(10 + &columns * 0.3)'

" Mappings
nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>u :UndotreeToggle<cr>

" Miscellaneous plugin settings
let g:highlightedyank_highlight_duration = 250
let g:rustfmt_autosave = 1
let g:zig_fmt_autosave = 1
runtime macros/sandwich/keymap/surround.vim

" Undotree
let g:undotree_HelpLine           = 0
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_CustomDiffpanelCmd = 'new'
function! s:undotree_rightbar()
	let g:undotree_CustomUndotreeCmd = 'belowright vertical '
				\ . eval(s:rightbar_width) . ' new'
endfunction
augroup UndotreeSettings
	autocmd!
	autocmd FileType undotree nnoremap <silent> <buffer> <esc>
				\ :UndotreeToggle<cr>
	autocmd FileType undotree nnoremap <silent> <buffer> <c-w>q
				\ :UndotreeToggle<cr>
	autocmd VimEnter,VimResized * call s:undotree_rightbar()
augroup END

" Fugitive
function! s:fugitive_rightbar()
	execute 'nnoremap <silent> <leader>g 
				\ :Git<cr><c-w>L<cr>:vertical resize '
				\ . eval(s:rightbar_width) . '<cr>'
endfunction
augroup FugitiveSettings
	autocmd!
	autocmd FileType fugitive nnoremap <silent> <buffer> <esc> <c-w>q
	autocmd VimEnter,VimResized * call s:fugitive_rightbar()
augroup END

" Dirvish
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore rightbelow split | Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | Dirvish <args>

" Vimwiki
function! s:vimwiki_settings()
	setlocal wrap linebreak
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

" Fzf
if isdirectory(glob('~/.fzf'))
	set rtp^=~/.fzf
endif
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
command! -bang -nargs=? -complete=dir Files
			\ call fzf#vim#files(<q-args>, <bang>0)
command! -bang Buffers call fzf#vim#buffers(<bang>0)
function! s:fzf_rightbar()
	let g:fzf_layout = { 'right': eval(s:rightbar_width) }
endfunction
augroup FzfSettings
	autocmd!
	autocmd FileType fzf tnoremap <silent> <buffer> <c-w>q <esc>
	autocmd VimEnter,VimResized * call s:fzf_rightbar()
augroup END

" Lightline
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
function! s:lightline_settings()
	if exists('g:colors_name')
		let g:lightline.colorscheme = g:colors_name
	endif
	call g:lightline#enable()
endfunction
augroup LightlineSettings
	autocmd!
	autocmd VimEnter,ColorScheme * call s:lightline_settings()
augroup END
