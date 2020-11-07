packadd fzf
nnoremap <silent> <Leader>f <Cmd>call fzf#run({'sink': 'edit', 'source': 'fd --hidden --ignore-file '.expand('$XDG_CONFIG_HOME').'/ignore -tf -td', 'window': 'new'})<CR>
