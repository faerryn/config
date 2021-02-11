if has('nvim-0.5.0')
	finish
endif

call minpac#add('junegunn/fzf', {'type': 'opt', 'do': {-> fzf#install()}})
