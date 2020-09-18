let g:lightline = {}
let g:lightline.tabline = { 'right': [] }
function! s:sync_lightline_colorscheme()
	if exists('g:colors_name')
		let g:lightline.colorscheme = g:colors_name
	else
		let g:lightline.colorscheme = 'default'
	endif
	call lightline#enable()
endfunction
autocmd VimEnter,ColorScheme * call s:sync_lightline_colorscheme()
