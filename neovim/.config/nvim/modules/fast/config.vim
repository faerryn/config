let s:fast = v:false

function! s:fast() abort
	if !s:fast
		syntax off
		filetype plugin off
		set noswapfile
		let s:fast = v:true
	else
		syntax on
		filetype plugin on
		set swapfile
		let s:fast = v:false
	endif
endfunction

command! -bar Fast call s:fast()
