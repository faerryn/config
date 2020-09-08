if executable('rg')
	let &grepprg='rg --no-messages --hidden --vimgrep'
	set grepformat=%f:%l:%c:%m
else
	set grepprg=internal
endif
