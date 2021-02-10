if executable('fzf')
	finish
endif

call minpac#add('junegunn/fzf', {'type': 'opt', 'do': {-> fzf#install()}})
