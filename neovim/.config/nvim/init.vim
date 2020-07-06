" AUTOCOMMANDS
augroup AutoCommands
	autocmd!

	autocmd VimEnter * silent! helptags ALL
	autocmd VimEnter * runtime macros/sandwich/keymap/surround.vim

	" Setting up <esc> and <c-w>q
	autocmd FileType help,qf,fugitive nnoremap <silent> <buffer> <esc> <c-w>q
	autocmd FileType Mundo,MundoDiff nnoremap <silent> <buffer> <esc> <cmd>MundoHide<cr>

augroup END

" FLAGS
let g:mapleader="\<space>"
set clipboard=unnamed,unnamedplus
set hidden
set mouse=ar
set nrformats+=alpha,octal
set omnifunc=syntaxcomplete#Complete
set spell
set timeoutlen=300
set undofile
set updatetime=300

let g:rustfmt_autosave = 1

let g:zig_fmt_autosave = 1

let g:textobj_sandwich_no_default_key_mappings = 1

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

let g:mundo_right = 1
let g:mundo_return_on_revert = 0
let g:mundo_auto_preview_delay = 300

let g:vimwiki_list = [{"path": "~/vimwiki/", "syntax": "markdown", "ext": ".md"}]

let $FZF_DEFAULT_COMMAND="fd -HL -E \"**/.git\" -tf"

" may be obsoleted
let g:highlightedyank_highlight_duration = 300

" AESTHETICS
set cursorline cursorcolumn colorcolumn=80
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

let g:gruvbox_contrast_dark = "medium"
let g:gruvbox_invert_signs = 1
let g:gruvbox_italic = 1
let g:gruvbox_italicize_strings = 1
colorscheme gruvbox

let g:lightline = { "colorscheme": "gruvbox", "separator": { "left": "", "right": "" }, "subseparator": { "left": "", "right": "" }, "tabline": { "right": [] } }
silent! call lightline#enable()

" MAPPINGS
nnoremap <silent> <leader>l <cmd>lopen<cr>
nnoremap <silent> <leader>q <cmd>copen<cr>

nnoremap <silent> <leader>g <cmd>G<cr>
nnoremap <silent> <leader>f <cmd>FZF<cr>
nnoremap <silent> <leader>u <cmd>MundoToggle<cr><cmd>MundoShow<cr>

" COMMANDS
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
