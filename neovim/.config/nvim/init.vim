" PLUGINS
if isdirectory(glob('~/.fzf'))
	set runtimepath^=~/.fzf
endif
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

" AUTOCOMMANDS
augroup AutoCommands
	autocmd!

	" Automatic sourcing of $MYVIMRC
	execute 'autocmd BufWritePost $MYVIMRC source $MYVIMRC'

	autocmd VimEnter * silent! helptags ALL
	autocmd VimEnter * runtime macros/sandwich/keymap/surround.vim

	" Prose
	autocmd FileType vimwiki,gitcommit setlocal wrap linebreak

	" Setting up <esc> and <c-w>q
	autocmd FileType fzf tnoremap <silent> <buffer> <c-w>q <esc>
	autocmd FileType help,qf,fugitive nnoremap <silent> <buffer> <esc> <c-w>q
	autocmd FileType undotree nnoremap <silent> <buffer> <c-w>q <cmd>UndotreeHide<cr>
	autocmd FileType undotree nnoremap <silent> <buffer> <esc> <cmd>UndotreeHide<cr>

augroup END

" FLAGS
let g:mapleader=' '
set clipboard=unnamed,unnamedplus
set cursorline cursorcolumn
set foldmethod=syntax foldlevelstart=20
set hidden
set lazyredraw
set list listchars=tab:\ \ ,trail:-,nbsp:+
set mouse=ar
set nowrap
set number relativenumber
set omnifunc=syntaxcomplete#Complete
set signcolumn=yes
set spell spellfile=~/.config/nvim/spellfile.utf-8.add
set splitbelow splitright
set tabstop=8 shiftwidth=8
set termguicolors
set timeoutlen=300
set undofile
set updatetime=300

let g:rustfmt_autosave = 1
let g:textobj_sandwich_no_default_key_mappings = 1
let g:undotree_HelpLine = 0
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 3
let g:zig_fmt_autosave = 1

" may be obsoleted
let g:highlightedyank_highlight_duration = 300
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1

" AESTHETICS
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_invert_signs = 1
let g:gruvbox_italic = 1
let g:gruvbox_italicize_strings = 1
colorscheme gruvbox
let g:lightline = { 'colorscheme': 'gruvbox' }
let g:lightline.tabline = { 'right': [] }
silent! call lightline#enable()

" MAPPINGS
nnoremap / /\v\c
nnoremap ? ?\v\c

nnoremap <silent> <leader>l <cmd>lopen<cr>
nnoremap <silent> <leader>c <cmd>copen<cr>

nnoremap <silent> <leader>g <cmd>G<cr>
nnoremap <silent> <leader>f <cmd>FZF<cr>
nnoremap <silent> <leader>u <cmd>UndotreeShow<cr>

" COMMANDS
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
