" Autosourcing
augroup SourceVimConfig
	execute 'autocmd! BufWritePost ' . expand('<sfile>')
				\ . ' source ' . expand('<sfile>')
augroup END

" Master control settings for plugins
let s:random_colorschemes = ['gruvbox', 'nord', 'onehalfdark']
let s:rightbar_width = 'float2nr(10 + &columns * 0.3)'

" Random colorschemes
if !exists('g:colors_name')
	execute "colorscheme " . s:random_colorschemes[
					\ system("echo $RANDOM") % len(s:random_colorschemes)]
endif

" Mappings
nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>u :UndotreeToggle<cr>

" Miscellaneous plugin settings
let g:highlightedyank_highlight_duration = 250
let g:rustfmt_autosave = 1
let g:zig_fmt_autosave = 1
runtime macros/sandwich/keymap/surround.vim

let g:undotree_HelpLine           = 0
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_CustomDiffpanelCmd = 'new'
function! s:undotree_rightbar()
	let g:undotree_CustomUndotreeCmd = 'belowright vertical '
				\ . eval(s:rightbar_width) . ' new'
endfunction
augroup UndotreeSettings
	autocmd!
	autocmd FileType undotree nnoremap <silent> <buffer> <esc>
				\ :UndotreeToggle<cr>
	autocmd VimResized * call s:undotree_rightbar()
augroup END
call s:undotree_rightbar()

function! s:fugitive_rightbar()
	execute 'nnoremap <silent> <leader>g 
				\ :Git<cr><c-w>L<cr>:vertical resize '
				\ . eval(s:rightbar_width) . '<cr>'
endfunction
augroup FugitiveSettings
	autocmd!
	autocmd FileType fugitive nnoremap <silent> <buffer> <esc> <c-w>q
	autocmd VimResized * call s:fugitive_rightbar()
augroup END
call s:fugitive_rightbar()

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore rightbelow split | Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | Dirvish <args>

function! s:vimwiki_settings()
	setlocal wrap linebreak spell
	nnoremap <silent> <buffer> j gj
	vnoremap <silent> <buffer> j gj
	nnoremap <silent> <buffer> k gk
	vnoremap <silent> <buffer> k gk
	nnoremap <silent> <buffer> 0 g0
	vnoremap <silent> <buffer> 0 g0
	nnoremap <silent> <buffer> $ g$
	vnoremap <silent> <buffer> $ g$
endfunction
augroup VimwikiSettings
	autocmd!
	autocmd FileType vimwiki call s:vimwiki_settings()
augroup END

let g:fzf_colors = { 
			\ 'fg':      ['fg', 'Normal'],
			\ 'bg':      ['bg', 'Normal'],
			\ 'hl':      ['fg', 'Comment'],
			\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
			\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
			\ 'hl+':     ['fg', 'Statement'],
			\ 'info':    ['fg', 'PreProc'],
			\ 'border':  ['fg', 'Ignore'],
			\ 'prompt':  ['fg', 'Conditional'],
			\ 'pointer': ['fg', 'Exception'],
			\ 'marker':  ['fg', 'Keyword'],
			\ 'spinner': ['fg', 'Label'],
			\ 'header':  ['fg', 'Comment']
			\ }
command! -bang -nargs=? -complete=dir Files
			\ call fzf#vim#files(<q-args>, <bang>0)
command! -bang Buffers call fzf#vim#buffers(<bang>0)
function! s:fzf_rightbar()
	let g:fzf_layout = { 'right': eval(s:rightbar_width) }
endfunction
augroup FzfSettings
	autocmd!
	autocmd VimResized * call s:fzf_rightbar()
augroup END
call s:fzf_rightbar()

let g:lightline = { 
			\ 'active': {
			\	'left': [
			\ 		[ 'mode', 'paste' ],
			\ 		[ 'gitbranch', 'readonly', 'filename', 'modified' ]
			\ 	]
			\ },
			\ 'component_function': { 'gitbranch': 'FugitiveHead' },
			\ 'separator': { 'left': '', 'right': '' },
			\ 'subseparator': { 'left': '', 'right': '' },
			\ }
function! s:lightline_settings()
	let g:lightline.colorscheme = g:colors_name
	call g:lightline#enable()
endfunction
augroup LightlineSettings
	autocmd!
	autocmd ColorScheme * call s:lightline_settings()
augroup END
call s:lightline_settings()

if has('nvim-0.5.0')

	lua require'nvim_lsp'.clangd.setup{}
	lua require'nvim_lsp'.rls.setup{}
	function s:lsp_settings()
		nnoremap <silent> <buffer> gd
					\ <cmd>lua vim.lsp.buf.declaration()<CR>
		nnoremap <silent> <buffer> <c-]>
					\ <cmd>lua vim.lsp.buf.definition()<CR>
		nnoremap <silent> <buffer> K
					\ <cmd>lua vim.lsp.buf.hover()<CR>
		nnoremap <silent> <buffer> gD
					\ <cmd>lua vim.lsp.buf.implementation()<CR>
		nnoremap <silent> <buffer> <c-k>
					\ <cmd>lua vim.lsp.buf.signature_help()<CR>
		nnoremap <silent> <buffer> 1gD
					\ <cmd>lua vim.lsp.buf.type_definition()<CR>
		nnoremap <silent> <buffer> gr
					\ <cmd>lua vim.lsp.buf.references()<CR>
		nnoremap <silent> <buffer> g0
					\ <cmd>lua vim.lsp.buf.document_symbol()<CR>
		nnoremap <silent> <buffer> gW
					\ <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
		setlocal omnifunc=v:lua.vim.lsp.omnifunc
	endfunction
	augroup LspSettings
		autocmd!
		autocmd FileType cpp,rust call s:lsp_settings()
	augroup END

else

	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_check_on_open            = 1

endif
