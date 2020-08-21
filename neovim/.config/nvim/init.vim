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

autocmd TextYankPost * lua vim.highlight.on_yank{timeout=500}

let g:asmsyntax='nasm'

packloadall

" gruvbox
colorscheme gruvbox

" vim-fugitive
autocmd FileType fugitive nnoremap <silent> <buffer> <Esc> <Cmd>q<CR>
nnoremap <silent> <Leader>g <Cmd>Git<CR>

" vim-sandwich
let g:sandwich_no_default_key_mappings = 1
let g:operator_sandwich_no_default_key_mappings = 1
let g:textobj_sandwich_no_default_key_mappings = 1
let g:sandwich#recipes = [
	    \ {'buns': ['(', ')'], 'linewise': 0, 'input': ['(', ')', 'b']},
	    \ {'buns': ['{', '}'], 'linewise': 0, 'input': ['{', '}', 'B']},
	    \ {'buns': ['[', ']'], 'linewise': 0, 'input': ['[', ']', 'r']},
	    \ {'buns': ['<', '>'], 'linewise': 0, 'input': ['<', '>', 'a']},
	    \ {'buns': ['"', '"'], 'linewise': 0},
	    \ {'buns': ["'", "'"], 'linewise': 0},
	    \ {'buns': ["`", "`"], 'linewise': 0},
	    \ ]
nmap sa <Plug>(operator-sandwich-add)
xmap sa <Plug>(operator-sandwich-add)
nmap sd <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nmap sr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)

" vim-textobj-user
call textobj#user#plugin('personal', {
	    \	'square': {
	    \	    'pattern': ['\[', '\]'],
	    \       'select-a': 'ar',
	    \       'select-i': 'ir',
	    \	},
	    \	'angle': {
	    \	    'pattern': ['<', '>'],
	    \       'select-a': 'aa',
	    \       'select-i': 'ia',
	    \	},
	    \ })

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
