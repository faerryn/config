" core
set clipboard=unnamed,unnamedplus
set confirm
set hidden
set lazyredraw
set mouse=ar
set nrformats=alpha,octal,hex,bin
set omnifunc=syntaxcomplete#Complete
set spell spellcapcheck=
set splitbelow splitright
set timeoutlen=500
set undofile
set updatetime=50

let &grepprg='rg --vimgrep'
let g:mapleader=' '

autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
autocmd BufEnter * if len(expand('%')) > 0 | execute 'cd ' expand('%:h') | endif

noremap <Leader> <Nop>
noremap s <Nop>

nnoremap Y y$

nnoremap <Leader>l <Cmd>lopen<CR>
nnoremap <Leader>q <Cmd>copen<CR>

autocmd FileType qf nnoremap <buffer> <Esc> <C-W>c

silent! execute 'mkspell! ' g:personal_vim_d '/spell/*.add'

" aesthetics
set cursorline cursorcolumn colorcolumn=80
set inccommand=nosplit
set noequalalways
set noruler
set noshowmode
set nowrap linebreak
set number relativenumber signcolumn=yes "number
set showtabline=0
set softtabstop=4 shiftwidth=4
set termguicolors

" vim-highlightedyank 
" autocmd TextYankPost * lua vim.highlight.on_yank{timeout=500}
let g:highlightedyank_highlight_duration = 500

" lightline.vim
let g:lightline = { 'colorscheme': 'gruvbox' }

" vim-startify
let g:startify_enable_special = 0
autocmd User Startified execute 'nunmap <buffer> q'

" vim-fugitive
autocmd FileType fugitive nnoremap <buffer> <Esc> <C-W>c
nnoremap <Leader>g <Cmd>Git<CR>

" vim-sandwich
let g:sandwich_no_default_key_mappings=1
let g:operator_sandwich_no_default_key_mappings=1
let g:textobj_sandwich_no_default_key_mappings=1
let g:sandwich#recipes=[
	    \ {'buns': ['(', ')'], 'nesting': -1, 'linewise': 0, 'input': ['(', ')', 'b']},
	    \ {'buns': ['{', '}'], 'nesting': -1, 'linewise': 0, 'input': ['{', '}', 'B']},
	    \ {'buns': ['[', ']'], 'nesting': -1, 'linewise': 0},
	    \ {'buns': ['<', '>'], 'nesting': -1, 'linewise': 0},
	    \ ]
map  sa <Plug>(operator-sandwich-add)
nmap sd <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nmap sr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)

" swap.vim
let g:swap_no_default_key_mappings=1
nmap sh <Plug>(swap-prev)
nmap sl <Plug>(swap-next)

" undotree
let g:undotree_CustomUndotreeCmd='split'
let g:undotree_CustomDiffpanelCmd='"'
let g:undotree_HelpLine=0
nnoremap <Leader>u <Cmd>UndotreeShow<CR>:UndotreeFocus<CR><Cmd>set ft=undotree<CR>
autocmd FileType undotree nnoremap <buffer> <Esc> <Cmd>UndotreeHide<CR>
autocmd FileType undotree nnoremap <buffer> <C-W>c <Cmd>UndotreeHide<CR>

" zig.vim
let g:zig_fmt_autosave=1
