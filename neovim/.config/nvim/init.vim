let g:mapleader=' '
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

nnoremap <silent> <leader>l <cmd>lopen<cr>
nnoremap <silent> <leader>c <cmd>copen<cr>

nnoremap / /\v
nnoremap ? ?\v

nnoremap <silent> <leader>g <cmd>G<cr>
nnoremap <silent> <leader>f <cmd>Files<cr>

let g:gruvbox_italic = 1
let g:gruvbox_italicize_strings = 1
let g:gruvbox_contrast_dark = 'medium'
colorscheme gruvbox

augroup AutoSourceInitVim
	autocmd!
	execute 'autocmd BufWritePost $MYVIMRC,' . resolve($MYVIMRC)
				\ . ' source $MYVIMRC'
augroup END
command! Resource source $MYVIMRC

augroup GenerateHelpTags
	autocmd!
	autocmd VimEnter * silent! helptags ALL
augroup END

augroup ProseSettings
	autocmd!
	autocmd FileType vimwiki,gitcommit setlocal wrap linebreak spell
augroup END

let g:rustfmt_autosave = 1
let g:zig_fmt_autosave = 1

" check out https://github.com/neovim/neovim/pull/12279
let g:highlightedyank_highlight_duration = 300

" check out https://github.com/neovim/nvim-lsp
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open            = 1

let g:textobj_sandwich_no_default_key_mappings = 1
augroup VimSandwichKeymap
	autocmd!
	autocmd VimEnter * runtime macros/sandwich/keymap/surround.vim
augroup END

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
augroup FzfStandardQuit
	autocmd!
	autocmd FileType fzf tnoremap <silent> <buffer> <c-w>q <esc>
	autocmd FileType fzf tnoremap <silent> <buffer> <esc> <nop>
augroup END

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
