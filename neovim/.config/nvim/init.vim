execute "augroup Personal"
autocmd!

let g:mapleader="\<space>"
set clipboard=unnamed,unnamedplus
set confirm
set hidden
set ignorecase smartcase
set lazyredraw
set mouse=ar
set nrformats=alpha,octal,hex,bin
set omnifunc=syntaxcomplete#Complete
set spell
set splitbelow splitright
set timeoutlen=500
set undofile
set updatetime=500

set background=dark
set cursorline cursorcolumn colorcolumn=80
set foldmethod=syntax foldlevelstart=20
set nowrap linebreak
set number relativenumber
set tabstop=4 shiftwidth=4 expandtab
set termguicolors

if has("nvim")
    autocmd TextYankPost * lua require'vim.highlight'.on_yank{timeout=500}
    let g:asmsyntax = 'nasm'
    set inccommand=split
endif

silent execute "mkspell! " . fnamemodify($MYVIMRC, ":h") . "/spell/*.add"

map Y y$

autocmd VimEnter * silent! helptags ALL

nnoremap <silent> <leader>d :digraphs!<cr>
nnoremap <silent> <leader>l :lopen<cr>
nnoremap <silent> <leader>q :copen<cr>

autocmd FileType help,qf nnoremap <silent> <buffer> <esc> <c-w>q

" vim-sandwich
autocmd VimEnter * runtime macros/sandwich/keymap/surround.vim
nmap s <plug>(operator-sandwich-add)
nmap S s$

" vim-dirvish
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" undotree
let g:undotree_HelpLine           = 0
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators    = 1
let g:undotree_WindowLayout       = 3
nnoremap <silent> <leader>u :UndotreeShow<cr>
autocmd FileType undotree nnoremap <silent> <buffer> <esc> :UndotreeHide<cr>

" vim-fugitive
autocmd FileType fugitive nnoremap <silent> <buffer> <esc> <c-w>q
nnoremap <silent> <leader>g :Git<cr>

" fzf
let g:fzf_preview_window = ''
nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>b :Buffers<cr>

" theme
colorscheme badwolf

execute "augroup END"
