let s:prose_mode = v:false

function! s:prose() abort
	if !s:prose_mode
		nnoremap j gj
		nnoremap k gk
		nnoremap 0 g0
		nnoremap $ g$
		nnoremap _ g_
		nnoremap ^ g^
	else
		unmap j
		unmap k
		unmap 0
		unmap $
		unmap _
		unmap ^
	endif
endfunction

command! Prose call s:prose()
