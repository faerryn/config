if !executable('fzf')
	packadd fzf
endif

nnoremap <Leader>f <cmd>FZF<CR>
