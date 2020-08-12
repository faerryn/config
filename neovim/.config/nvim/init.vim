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
set updatetime=50

let g:mapleader="\<Space>"

noremap <silent> s        <Nop>
noremap <silent> S        <Nop>
noremap <silent> <Leader> <Nop>

nnoremap <silent> Y y$
noremap  <silent> Q @@

nnoremap <silent> <Leader>l <cmd>lopen<CR>
nnoremap <silent> <Leader>q <cmd>copen<CR>

autocmd FileType qf nnoremap <silent> <buffer> <esc> <cmd>q<CR>

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
set shortmess=o
set softtabstop=4 shiftwidth=4
set termguicolors

colorscheme gruvbox

autocmd TextYankPost * lua vim.highlight.on_yank{timeout=500}

let g:asmsyntax='nasm'

" netrw
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

" vim-fugitive
autocmd FileType fugitive nnoremap <silent> <buffer> <Esc> <cmd>q<CR>
nnoremap <silent> <Leader>g <cmd>Git<CR>

" fzf
nnoremap <silent> <Leader>f <cmd>call fzf#run({"window": {"width": 0.8, "height": 0.6}, "source": "fd -Htf", "sink": "e"})<cr>
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
nmap sa <Plug>(operator-sandwich-add)
xmap sa <Plug>(operator-sandwich-add)
nmap sd <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nmap sr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)

" undotree
let g:undotree_CustomUndotreeCmd="split"
let g:undotree_CustomDiffpanelCmd="split"
let g:undotree_DiffpanelHeight=5
let g:undotree_HelpLine = 0
nnoremap <silent> <Leader>u <cmd>UndotreeShow<CR>:UndotreeFocus<CR>
autocmd FileType undotree nnoremap <silent> <buffer> <Esc> <cmd>UndotreeHide<CR>

" nvim-lsp
packadd nvim-lsp
lua require'nvim_lsp'.clangd.setup{}

function s:personal_setup_lsp()
    if luaeval("table.getn(vim.lsp.buf_get_clients()) > 0")
	nnoremap <buffer> <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
	nnoremap <buffer> <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
	nnoremap <buffer> <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
	nnoremap <buffer> <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
	nnoremap <buffer> <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
	nnoremap <buffer> <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
	nnoremap <buffer> <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
	nnoremap <buffer> <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
	nnoremap <buffer> <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
	autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
	setlocal omnifunc=v:lua.vim.lsp.omnifunc
    endif
endfunction
autocmd BufEnter * call s:personal_setup_lsp()

execute "augroup END"
