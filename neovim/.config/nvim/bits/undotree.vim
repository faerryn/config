nnoremap <silent> <Leader>u <cmd>UndotreeShow<CR><cmd>UndotreeFocus<CR><cmd>set filetype=undotree<CR>
autocmd FileType undotree nnoremap <silent> <buffer> <Esc> <cmd>UndotreeHide<CR>
autocmd FileType undotree nnoremap <silent> <buffer> <C-W>c <cmd>UndotreeHide<CR>
