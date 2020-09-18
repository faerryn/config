nnoremap <silent> <leader><leader> <cmd>Goyo<CR>

function! s:goyo_enter()
	set scrolloff=999
	Limelight
endfunction

function! s:goyo_leave()
	set scrolloff=0
	Limelight!
endfunction

autocmd! User GoyoEnter call s:goyo_enter()
autocmd! User GoyoLeave call s:goyo_leave()
