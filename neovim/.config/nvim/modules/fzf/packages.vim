if executable('fzf')
	let s:doc_dir = stdpath('data').'/site/doc'
	call system('curl https://raw.githubusercontent.com/junegunn/fzf/master/doc/fzf.txt --create-dirs -o '.s:doc_dir.'/fzf.txt')
	silent! execute 'helptags' s:doc_dir
else
	call minpac#add('junegunn/fzf', {'type': 'opt', 'do': {-> fzf#install()}})
endif
