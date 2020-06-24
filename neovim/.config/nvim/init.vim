" AUTOCOMMANDS
augroup AutoCommands
	autocmd!

	" Automatic sourcing of $MYVIMRC
	execute 'autocmd BufWritePost $MYVIMRC source $MYVIMRC'

	" Helptags
	autocmd VimEnter * silent! helptags ALL

	" vim-sandwich with vim-surround mappings
	autocmd VimEnter * runtime macros/sandwich/keymap/surround.vim

	" Prose
	autocmd FileType vimwiki,gitcommit setlocal wrap linebreak

	" Setting up <esc> and <c-w>q
	autocmd FileType help,qf,fugitive nnoremap <silent> <buffer> <esc> <c-w>q
	autocmd FileType undotree nnoremap <silent> <buffer> <c-w>q <cmd>UndotreeHide<cr>
	autocmd FileType undotree nnoremap <silent> <buffer> <esc> <cmd>UndotreeHide<cr>

augroup END

" PLUGINS
if isdirectory(glob('~/.local/share/fzf'))
	set runtimepath^=~/.local/share/fzf
endif

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

" FLAGS
let g:mapleader=' '
set clipboard=unnamed,unnamedplus
set hidden
set mouse=ar
set nrformats+=alpha,octal
set omnifunc=syntaxcomplete#Complete
set spell spellfile=~/.config/nvim/spellfile.utf-8.add
set timeoutlen=300
set undofile
set updatetime=300

let g:rustfmt_autosave = 1

let g:zig_fmt_autosave = 1

let g:textobj_sandwich_no_default_key_mappings = 1

let g:undotree_HelpLine = 0
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 3

" may be obsoleted
let g:highlightedyank_highlight_duration = 300

" AESTHETICS
set cursorline cursorcolumn
set foldmethod=syntax foldlevelstart=20
set inccommand=split
set lazyredraw
set list listchars=tab:\ \ ,trail:-,nbsp:+
set noshowmode
set nowrap
set number relativenumber
set signcolumn=yes
set splitbelow splitright
set termguicolors

let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_invert_signs = 1
let g:gruvbox_italic = 1
let g:gruvbox_italicize_strings = 1
colorscheme gruvbox

" MAPPINGS
nnoremap / /\v\c
nnoremap ? ?\v\c

nnoremap <silent> <leader>l <cmd>lopen<cr>
nnoremap <silent> <leader>q <cmd>copen<cr>

nnoremap <silent> <leader>g <cmd>G<cr>
nnoremap <silent> <leader>f <cmd>FZF<cr>
nnoremap <silent> <leader>u <cmd>UndotreeShow<cr>

" COMMANDS
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
