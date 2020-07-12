execute "augroup Personal"
autocmd!

let g:mapleader="\<space>"
set clipboard=unnamed,unnamedplus
set confirm
set cursorline cursorcolumn colorcolumn=80
set foldmethod=syntax foldlevelstart=20
set hidden
set inccommand=split
set lazyredraw
set list listchars=tab:\ \ ,trail:-,nbsp:+
set mouse=ar
set noshowmode
set nowrap linebreak
set nrformats+=alpha,octal
set number relativenumber
set omnifunc=syntaxcomplete#Complete
set signcolumn=yes
set spell
set splitbelow splitright
set tabstop=8 softtabstop=4 shiftwidth=4
set termguicolors
set timeoutlen=500
set undofile
set updatetime=500

map Y y$

autocmd VimEnter * silent! helptags ALL
if has("nvim-0.5.0")
    autocmd TextYankPost * lua require'vim.highlight'.on_yank{timeout=500}
fi

nnoremap <silent> <leader>l <cmd>lopen<cr>
nnoremap <silent> <leader>q <cmd>copen<cr>

" Setting up q to quit for help, qf
autocmd FileType help,qf nnoremap <silent> <buffer> q <c-w>q

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
let g:undotree_HelpLine = 0
let g:undotree_WindowLayout = 3
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
nnoremap <silent> <leader>u <cmd>UndotreeShow<cr>

" vim-fugitive
nnoremap <silent> <leader>g <cmd>G<cr>
autocmd FileType fugitive nnoremap <silent> <buffer> q <c-w>q

" fzf
nnoremap <silent> <leader>f <cmd>Files<cr>
nnoremap <silent> <leader>b <cmd>Buffers<cr>
let g:fzf_preview_window = ''

" gruvbox
let g:gruvbox_contrast_dark = "medium"
let g:gruvbox_invert_signs = 1
let g:gruvbox_italic = 1
let g:gruvbox_italicize_strings = 1
colorscheme gruvbox

" lightline.vim
let g:lightline = { "colorscheme": "gruvbox",
	    \"separator": { "left": "", "right": "" },
	    \"subseparator": { "left": "", "right": "" },
	    \"tabline": { "right": [] } }

if has("nvim-0.5.0")
    " nvim-lsp
    packadd nvim-lsp
    function s:setup_lsp()
	nnoremap <silent> <buffer> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
	nnoremap <silent> <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
	nnoremap <silent> <buffer> K     <cmd>lua vim.lsp.buf.hover()<CR>
	nnoremap <silent> <buffer> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
	nnoremap <silent> <buffer> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
	nnoremap <silent> <buffer> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
	nnoremap <silent> <buffer> gr    <cmd>lua vim.lsp.buf.references()<CR>
	nnoremap <silent> <buffer> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
	nnoremap <silent> <buffer> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
	nnoremap <silent> <buffer> gA    <cmd>lua vim.lsp.buf.code_action()<CR>
	setlocal omnifunc=v:lua.vim.lsp.omnifunc
	augroup PersonalNvimLsp
	    autocmd! * <buffer>
	    autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
	augroup END
    endfunction

    lua require'nvim_lsp'.rust_analyzer.setup{}
    autocmd FileType rust call s:setup_lsp()

    lua require'nvim_lsp'.clangd.setup{ cmd = { "clangd", "--background-index" }, filetypes = { "cpp" } }
    autocmd FileType cpp call s:setup_lsp()
endif

execute "augroup END"
