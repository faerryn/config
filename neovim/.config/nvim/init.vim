execute 'augroup Personal'
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
set shada=
set splitbelow splitright
set timeoutlen=500
set undofile
set updatetime=500

let &grepprg = 'rg --vimgrep'
let g:mapleader=' '

noremap <Leader> <Nop>
noremap S        <Nop>
noremap s        <Nop>

nnoremap Y y$
noremap  Q @@

nnoremap <Leader>l <Cmd>lopen<CR>
nnoremap <Leader>q <Cmd>copen<CR>

autocmd FileType qf nnoremap <buffer> <Esc> <C-W>c

silent! execute 'mkspell! ' . fnamemodify($MYVIMRC, ':h') . '/spell/*.add'
autocmd VimEnter * silent! helptags ALL

" aesthetics
set cursorline cursorcolumn colorcolumn=80
set inccommand=nosplit
set laststatus=0 showtabline=0
set noequalalways
set noruler
set nowrap linebreak
set number relativenumber signcolumn=number
set softtabstop=4 shiftwidth=4
set termguicolors

autocmd TextYankPost * lua vim.highlight.on_yank{timeout=500}

let g:asmsyntax='nasm'

packloadall

" gruvbox
colorscheme gruvbox

" vim-fugitive
autocmd FileType fugitive nnoremap <buffer> <Esc> <C-W>c
nnoremap <Leader>g <Cmd>Git<CR>

" vim-sandwich
let g:sandwich_no_default_key_mappings = 1
let g:operator_sandwich_no_default_key_mappings = 1
let g:textobj_sandwich_no_default_key_mappings = 1
let g:sandwich#recipes = [
	    \ {'buns': ['(', ')'], 'linewise': 0, 'input': ['(', ')', 'b']},
	    \ {'buns': ['{', '}'], 'linewise': 0, 'input': ['{', '}', 'B']},
	    \ {'buns': ['[', ']'], 'linewise': 0},
	    \ {'buns': ['<', '>'], 'linewise': 0},
	    \ ]
map  sa <Plug>(operator-sandwich-add)
nmap sd <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nmap sr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)

" undotree
let g:undotree_CustomUndotreeCmd='split'
let g:undotree_CustomDiffpanelCmd='split'
let g:undotree_DiffpanelHeight=5
let g:undotree_HelpLine = 0
nnoremap <Leader>u <Cmd>UndotreeShow<CR>:UndotreeFocus<CR>
autocmd FileType undotree nnoremap <buffer> <Esc> <Cmd>UndotreeHide<CR>

" zig.vim
let g:zig_fmt_autosave = 1

" rust.vim
let g:rustfmt_autosave = 1

" vim-go
let g:go_fmt_autosave = 1

execute 'augroup END'
