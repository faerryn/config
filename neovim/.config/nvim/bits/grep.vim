if executable('rg')
	let &grepprg='rg --hidden --ignore-file $XDG_CONFIG_HOME/rg/ignore --vimgrep'
	set grepformat=%f:%l:%c:%m
else
	set grepprg=internal
endif
