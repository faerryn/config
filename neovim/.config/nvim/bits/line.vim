function! s:last_line()
	if line("'\"") > 0 && line("'\"") <= line('$')
		execute "normal! g'\""
	endif
endfunction
autocmd BufReadPost * call s:last_line()
