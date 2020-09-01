function s:update_lightline()
    if exists('g:colors_name')
	let g:lightline={'colorscheme': g:colors_name}
	call lightline#enable()
    endif
endfunction
autocmd Faevim VimEnter * call s:update_lightline()
autocmd Faevim ColorScheme * call s:update_lightline()
