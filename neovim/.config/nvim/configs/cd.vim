let s:home=getcwd()
function s:jump()
    if !empty(@%) && empty(&buftype)
	cd %:h
    else
	execute 'cd' s:home
    endif
endfunction
autocmd BufEnter * call s:jump()
