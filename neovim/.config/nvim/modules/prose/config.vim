let s:prose_mode = v:false

function! s:prose() abort
	if !s:prose_mode
		noremap <silent> j gj
		noremap <silent> k gk
		noremap <silent> 0 g0
		noremap <silent> $ g$
		noremap <silent> _ g_
		noremap <silent> ^ g^
		let s:prose_mode = v:false
	else
		unmap j
		unmap k
		unmap 0
		unmap $
		unmap _
		unmap ^
		let s:prose_mode = v:true
	endif
endfunction

command! -bar Prose call s:prose()
