packadd fzf
if executable('fd')
	nnoremap <silent> <Leader>f <Cmd>call fzf#run({'sink': 'edit', 'source': 'fd --hidden --type=f --type=d', 'window': 'new'})<CR>
else
	nnoremap <silent> <Leader>f <Cmd>call fzf#run({'sink': 'edit', 'window': 'new'})<CR>
endif
