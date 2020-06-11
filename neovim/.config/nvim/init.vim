let g:mapleader=' '
set clipboard=unnamed,unnamedplus
set colorcolumn=80
set cursorline cursorcolumn
set foldmethod=syntax foldlevelstart=20
set hidden
set ignorecase smartcase
set lazyredraw
set list listchars=tab:\ \ ,trail:-,nbsp:+
set mouse=ar
set nowrap
set number relativenumber
set omnifunc=syntaxcomplete#Complete
set signcolumn=yes
set splitbelow splitright
set tabstop=4 shiftwidth=4
set termguicolors
set timeoutlen=300
set undofile
set updatetime=300

nnoremap / /\v
nnoremap ? ?\v

nnoremap <silent> <leader>l <cmd>lopen<cr>
nnoremap <silent> <leader>c <cmd>copen<cr>

nnoremap <silent> <leader>g <cmd>G<cr>
nnoremap <silent> <leader>f <cmd>Files<cr>

let g:gruvbox_italic = 1
let g:gruvbox_italicize_strings = 1
let g:gruvbox_contrast_dark = 'medium'
colorscheme gruvbox

augroup AutoCommands
	autocmd!
	execute 'autocmd BufWritePost $MYVIMRC,' . resolve($MYVIMRC)
				\ . ' source $MYVIMRC'
	autocmd VimEnter * silent! helptags ALL
	autocmd VimEnter * runtime macros/sandwich/keymap/surround.vim
	autocmd FileType vimwiki,gitcommit setlocal wrap linebreak spell
	autocmd FileType fzf tnoremap <silent> <buffer> <c-w>q <esc>
augroup END

let g:highlightedyank_highlight_duration = 300
let g:rustfmt_autosave = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:textobj_sandwich_no_default_key_mappings = 1
let g:zig_fmt_autosave = 1

if isdirectory(glob('~/.fzf'))
	set runtimepath^=~/.fzf
endif
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
			\ 'colorscheme': g:colors_name,
			\ }
if exists('*lightline#enable')
	call lightline#enable()
endif
