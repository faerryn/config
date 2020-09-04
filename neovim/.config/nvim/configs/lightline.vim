function! s:update_lightline() abort
	if exists('g:colors_name')
		let g:lightline={'colorscheme': g:colors_name}
		call lightline#enable()
	endif
endfunction
autocmd VimEnter * call s:update_lightline()
autocmd ColorScheme * call s:update_lightline()
call s:update_lightline()
