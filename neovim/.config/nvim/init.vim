execute "augroup Personal"
autocmd!

" core
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
set updatetime=500

let g:mapleader="\<space>"

noremap <silent> s        <nop>
noremap <silent> S        <nop>
noremap <silent> <leader> <nop>

noremap <silent> Y y$
noremap <silent> Q @@

nnoremap <silent> <leader>l :lopen<cr>
nnoremap <silent> <leader>q :copen<cr>

autocmd FileType help,qf nnoremap <silent> <buffer> <esc> :q<cr>

silent! execute "mkspell! " . fnamemodify($MYVIMRC, ":h") . "/spell/*.add"
autocmd VimEnter * silent! helptags ALL

" aesthetics
set background=dark
set cursorline cursorcolumn colorcolumn=80
set hlsearch incsearch
set nowrap linebreak
set number relativenumber
set tabstop=4 shiftwidth=4 expandtab
set termguicolors

colorscheme gruvbox
syntax enable

let g:asmsyntax='nasm'

" vim/neovim compat
if has("nvim")
    set inccommand=split
    set shada=
else
    set viminfo=
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" PLUGINS
" vim-dirvish
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

" vim-fugitive
autocmd FileType fugitive nnoremap <silent> <buffer> <esc> :q<cr>
nnoremap <silent> <leader>g :Git<cr>

" vim-highlightedyank
let g:highlightedyank_highlight_duration = 500

execute "augroup END"
