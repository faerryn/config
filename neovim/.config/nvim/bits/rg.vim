if executable('rg')
	let &grepprg='rg --hidden --vimgrep'
	let &grepformat='%f:%l:%c:%m'
endif
