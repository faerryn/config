execute "augroup AutoCommands"
autocmd!

let g:mapleader="\<space>"
set clipboard=unnamed,unnamedplus
set cursorline cursorcolumn colorcolumn=80
set foldmethod=syntax foldlevelstart=20
set hidden
set inccommand=split
set lazyredraw
set list listchars=tab:\ \ ,trail:-,nbsp:+
set mouse=ar
set noshowmode
set nowrap
set nrformats+=alpha,octal
set number relativenumber
set omnifunc=syntaxcomplete#Complete
set signcolumn=yes
set spell
set splitbelow splitright
set termguicolors
set timeoutlen=300
set undofile
set updatetime=300

autocmd VimEnter * silent! helptags ALL
autocmd TextYankPost * lua require'vim.highlight'.on_yank({timeout=300})

nnoremap <silent> <leader>l <cmd>lopen<cr>
nnoremap <silent> <leader>q <cmd>copen<cr>

" Setting up <esc> and <c-w>q
autocmd FileType help,qf,fugitive nnoremap <silent> <buffer> <esc> <c-w>q

" vim-polyglot
let g:rustfmt_autosave = 1
let g:zig_fmt_autosave = 1

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
autocmd FileType undotree nnoremap <silent> <buffer> <esc> <cmd>UndotreeHide<cr>

" vim-fugitive
nnoremap <silent> <leader>g <cmd>G<cr>

" fzf
let $FZF_DEFAULT_COMMAND="fd -HL -E \"**/.git\" -tf"
nnoremap <silent> <leader>f <cmd>FZF<cr>

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

" nvim-lsp
let s:lsp_triples = [ ["rust", "rust-analyzer", "rust_analyzer" ] ]

function s:setup_lsp(lsp_executable, lsp_config)
	if !executable(a:lsp_executable) | return | endif
	execute "lua require'nvim_lsp'." . a:lsp_config . ".setup{}"
	nnoremap <silent> <buffer> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
	nnoremap <silent> <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
	nnoremap <silent> <buffer> K     <cmd>lua vim.lsp.buf.hover()<CR>
	nnoremap <silent> <buffer> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
	nnoremap <silent> <buffer> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
	nnoremap <silent> <buffer> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
	nnoremap <silent> <buffer> gr    <cmd>lua vim.lsp.buf.references()<CR>
	nnoremap <silent> <buffer> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
	nnoremap <silent> <buffer> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
	setlocal omnifunc=v:lua.vim.lsp.omnifunc
endfunction
for s:triple in s:lsp_triples
	execute "autocmd FileType " . s:triple[0] . " call s:setup_lsp(\"" 
				\. s:triple[1] . "\", \"" . s:triple[2] . "\")"
endfor

execute "augroup END"
