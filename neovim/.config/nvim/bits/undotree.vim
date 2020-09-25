nnoremap <silent> <Leader>u <cmd>lua personal_undotree()<CR>
autocmd FileType undotree nnoremap <silent> <buffer> <Esc> <cmd>UndotreeHide<CR>
autocmd FileType undotree nnoremap <silent> <buffer> <C-W>c <cmd>UndotreeHide<CR>
