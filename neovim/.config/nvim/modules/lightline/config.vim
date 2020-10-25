let g:lightline = {'tabline': {'right': []}}
function! s:lightline_sync_colorscheme() abort
	if !exists('g:colors_name') | return | endif
	let g:lightline.colorscheme = g:colors_name
	call lightline#enable()
endfunction
autocmd Personal ColorScheme * call s:lightline_sync_colorscheme()
packadd lightline.vim
