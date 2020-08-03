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

noremap <silent> Y y$
noremap <silent> Q @@

noremap <silent> s        <nop>
noremap <silent> S        <nop>
noremap <silent> <leader> <nop>

nnoremap <silent> <leader>d :digraphs!<cr>
nnoremap <silent> <leader>l :lopen<cr>
nnoremap <silent> <leader>q :copen<cr>

autocmd FileType help,qf nnoremap <silent> <buffer> <esc> <c-w>q

silent! execute "mkspell! " . fnamemodify($MYVIMRC, ":h") . "/spell/*.add"
autocmd VimEnter * silent! helptags ALL

set cursorline cursorcolumn colorcolumn=80
set nowrap linebreak
set number relativenumber
set tabstop=4 shiftwidth=4 expandtab
set termguicolors
set inccommand=split

colorscheme gruvbox

let g:asmsyntax='nasm'

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

" highlightedyank
let g:highlightedyank_highlight_duration = 500

execute "augroup END"
