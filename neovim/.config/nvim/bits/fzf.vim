nnoremap <silent> <Leader>fb <cmd>Buffers<CR>
nnoremap <silent> <Leader>ff <cmd>Files<CR>
nnoremap <silent> <Leader>fp <cmd>execute 'Files' stdpath('config')<CR>
let g:fzf_preview_window = ''
let g:fzf_layout = { 'window': 'new' }
let $FZF_DEFAULT_COMMAND = 'fd --hidden -tf -td'
autocmd FileType fzf tnoremap <silent> <buffer> <Esc> <C-C>
