" PLUGINS
if isdirectory(glob('~/.fzf'))
	set runtimepath^=~/.fzf
endif

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

if has("nvim-0.5.0")
	packadd nvim-lsp

	function s:lsp_settings() 
		setlocal omnifunc=v:lua.vim.lsp.omnifunc
		nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<cr>
		nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
		nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<cr>
		nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<cr>
		nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<cr>
		nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<cr>
		nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<cr>
		nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<cr>
		nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<cr>
	endfunction

	lua require'nvim_lsp'.clangd.setup{}
	lua require'nvim_lsp'.rust_analyzer.setup{}

	augroup LspAutoCommands
		autocmd FileType rust,cpp call s:lsp_settings()
	augroup END
else
	packadd syntastic
endif

" AUTOCOMMANDS
augroup AutoCommands
	autocmd!

	" Automatic sourcing of $MYVIMRC
	execute 'autocmd BufWritePost $MYVIMRC source $MYVIMRC'

	" Helptags
	autocmd VimEnter * silent! helptags ALL

	" vim-sandwich with vim-surround mappings
	autocmd VimEnter * runtime macros/sandwich/keymap/surround.vim

	" Prose
	autocmd FileType vimwiki,gitcommit setlocal wrap linebreak

	" Setting up <esc> and <c-w>q
	autocmd FileType fzf tnoremap <silent> <buffer> <c-w>q <esc>
	autocmd FileType help,qf,fugitive nnoremap <silent> <buffer> <esc> <c-w>q
	autocmd FileType undotree nnoremap <silent> <buffer> <c-w>q <cmd>UndotreeHide<cr>
	autocmd FileType undotree nnoremap <silent> <buffer> <esc> <cmd>UndotreeHide<cr>

augroup END

" FLAGS
let g:mapleader=' '
set clipboard=unnamed,unnamedplus
set hidden
set mouse=ar
set nrformats+=alpha,octal
set omnifunc=syntaxcomplete#Complete
set spell spellfile=~/.config/nvim/spellfile.utf-8.add
set timeoutlen=300
set undofile
set updatetime=300

let g:rustfmt_autosave = 1

let g:zig_fmt_autosave = 1

let g:textobj_sandwich_no_default_key_mappings = 1

let g:undotree_HelpLine = 0
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 3

" may be obsoleted
let g:highlightedyank_highlight_duration = 300
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1

" AESTHETICS
set cursorline cursorcolumn
set foldmethod=syntax foldlevelstart=20
set inccommand=split
set lazyredraw
set list listchars=tab:\ \ ,trail:-,nbsp:+
set noshowmode
set nowrap
set number relativenumber
set signcolumn=yes
set splitbelow splitright
set termguicolors

let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_invert_signs = 1
let g:gruvbox_italic = 1
let g:gruvbox_italicize_strings = 1
colorscheme gruvbox

" MAPPINGS
nnoremap / /\v\c
nnoremap ? ?\v\c

nnoremap <silent> <leader>l <cmd>lopen<cr>
nnoremap <silent> <leader>q <cmd>copen<cr>

nnoremap <silent> <leader>g <cmd>G<cr>
nnoremap <silent> <leader>f <cmd>FZF<cr>
nnoremap <silent> <leader>u <cmd>UndotreeShow<cr>

" COMMANDS
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
