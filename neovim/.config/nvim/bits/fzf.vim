nnoremap <silent> <Leader>f <cmd>call fzf#run({'sink': 'edit', 'source': 'fd --hidden -tf -td', 'window': 'new'})<CR>
autocmd FileType fzf tnoremap <silent> <buffer> <Esc> <C-C>
