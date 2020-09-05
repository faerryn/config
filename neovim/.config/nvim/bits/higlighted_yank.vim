if has('nvim')
	autocmd TextYankPost * lua vim.highlight.on_yank{timeout=500}
else
	let g:highlightedyank_highlight_duration=500
endif
