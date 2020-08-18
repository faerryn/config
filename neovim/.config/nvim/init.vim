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
set shada=
set splitbelow splitright
set timeoutlen=500
set undofile
set updatetime=500

let &grepprg = "rg --vimgrep"
let g:mapleader="\<Space>"

noremap <silent> <Leader> <Nop>
noremap <silent> S        <Nop>
noremap <silent> s        <Nop>

nnoremap <silent> Y y$
noremap  <silent> Q @@

nnoremap <silent> <Leader>l <Cmd>lopen<CR>
nnoremap <silent> <Leader>q <Cmd>copen<CR>

autocmd FileType qf nnoremap <silent> <buffer> <esc> <Cmd>q<CR>

silent! execute "mkspell! " . fnamemodify($MYVIMRC, ":h") . "/spell/*.add"
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

colorscheme gruvbox

autocmd TextYankPost * lua vim.highlight.on_yank{timeout=500}

let g:asmsyntax='nasm'

" vim-fugitive
autocmd FileType fugitive nnoremap <silent> <buffer> <Esc> <Cmd>q<CR>
nnoremap <silent> <Leader>g <Cmd>Git<CR>

" fzf
nnoremap <silent> <Leader>f <Cmd>call fzf#run({"window": {"width": 0.8, "height": 0.6}, "source": "fd -H", "sink": "e"})<cr>
autocmd FileType fzf tnoremap <silent> <buffer> <Esc> <C-C>

" vim-sandwich
let g:sandwich_no_default_key_mappings = 1
let g:operator_sandwich_no_default_key_mappings = 1
let g:textobj_sandwich_no_default_key_mappings = 1
let g:sandwich#recipes = [
	    \ {'buns': ['(', ')'], 'nesting': 1, 'input': ['(', ')', 'b']},
	    \ {'buns': ['{', '}'], 'nesting': 1, 'skip_break': 1, 'input': ['{', '}', 'B']},
	    \ {'buns': ['[', ']'], 'nesting': 1, 'input': ['[', ']', 'r']},
	    \ {'buns': ['<', '>'], 'expand_range': 0},
	    \ {'buns': ['"', '"'], 'quoteescape': 1, 'expand_range': 0, 'nesting': 0, 'linewise': 0},
	    \ {'buns': ["'", "'"], 'quoteescape': 1, 'expand_range': 0, 'nesting': 0, 'linewise': 0},
	    \ {'buns': ["`", "`"], 'quoteescape': 1, 'expand_range': 0, 'nesting': 0, 'linewise': 0},
	    \ ]
nnoremap dir di[
nmap sa <Plug>(operator-sandwich-add)
xmap sa <Plug>(operator-sandwich-add)
nmap sd <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nmap sr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)

" undotree
let g:undotree_CustomUndotreeCmd="split"
let g:undotree_CustomDiffpanelCmd="split"
let g:undotree_DiffpanelHeight=5
let g:undotree_HelpLine = 0
nnoremap <silent> <Leader>u <Cmd>UndotreeShow<CR>:UndotreeFocus<CR>
autocmd FileType undotree nnoremap <silent> <buffer> <Esc> <Cmd>UndotreeHide<CR>

" zig.vim
let g:zig_fmt_autosave = 1

" rust.vim
let g:rustfmt_autosave = 1

" vim-go
let g:go_fmt_autosave = 1

execute "augroup END"
