nnoremap <silent> <Leader>b <cmd>Buffers<CR>
nnoremap <silent> <Leader>f <cmd>Files<CR>
let g:fzf_preview_window = ''
let g:fzf_layout = { 'window': 'new' }
let $FZF_DEFAULT_COMMAND = 'fd --hidden -tf -td'
autocmd FileType fzf tnoremap <silent> <buffer> <Esc> <C-C>
