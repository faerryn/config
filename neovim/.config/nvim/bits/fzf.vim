nnoremap <Leader>f <Cmd>Files<CR>
nnoremap <Leader>b <Cmd>Buffers<CR>
let g:fzf_preview_window=''
let $FZF_DEFAULT_COMMAND='fd --hidden -tf -td'
autocmd FileType fzf tnoremap <buffer> <Esc> <C-C>
