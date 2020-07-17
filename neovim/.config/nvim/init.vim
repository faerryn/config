let g:mapleader="\<space>"
set clipboard=unnamed,unnamedplus
set confirm
set cursorline cursorcolumn colorcolumn=80 signcolumn=yes
set foldmethod=syntax foldlevelstart=20
set hidden
set ignorecase smartcase
set lazyredraw
set list listchars=tab:\ \ ,trail:-,nbsp:+
set mouse=ar
set noshowmode
set nowrap linebreak
set nrformats=alpha,octal,hex,bin
set number relativenumber
set omnifunc=syntaxcomplete#Complete
set spell
set splitbelow splitright
set tabstop=8 softtabstop=4 shiftwidth=4
set termguicolors
set timeoutlen=500
set undofile
set updatetime=500

if has("nvim")
    set inccommand=split
else
    set background=dark
endif

map Y y$

execute "augroup Personal"
autocmd!

autocmd VimEnter * silent! helptags ALL
if has("nvim-0.5.0")
    autocmd TextYankPost * lua require'vim.highlight'.on_yank{timeout=500}
endif

nnoremap <silent> <leader>l :lopen<cr>
nnoremap <silent> <leader>q :copen<cr>

" Setting up q to quit for help, qf
autocmd FileType help,qf nnoremap <silent> <buffer> <esc> <c-w>q

" vim-sandwich
let g:textobj_sandwich_no_default_key_mappings = 1
autocmd VimEnter * runtime macros/sandwich/keymap/surround.vim

" vim-dirvish
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" undotree
let g:undotree_HelpLine           = 0
let g:undotree_WindowLayout       = 3
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators    = 1
nnoremap <silent> <leader>u :UndotreeShow<cr>
autocmd FileType undotree nnoremap <silent> <buffer> <esc> :UndotreeHide<cr>

" vim-fugitive
autocmd FileType fugitive nnoremap <silent> <buffer> <esc> <c-w>q
nnoremap <silent> <leader>g :G<cr>

" fzf
let g:fzf_preview_window = ''
nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>b :Buffers<cr>

" gruvbox
let g:gruvbox_contrast_dark     = "medium"
let g:gruvbox_invert_signs      = 1
let g:gruvbox_italic            = 1
let g:gruvbox_italicize_strings = 1
colorscheme gruvbox

execute "augroup END"
