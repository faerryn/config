let g:undotree_CustomUndotreeCmd='split'
let g:undotree_CustomDiffpanelCmd='"'
let g:undotree_HelpLine=0
nnoremap <Leader>u <Cmd>UndotreeShow<CR>:UndotreeFocus<CR><Cmd>set ft=undotree<CR>
autocmd Faevim FileType undotree nnoremap <buffer> <Esc> <Cmd>UndotreeHide<CR>
autocmd Faevim FileType undotree nnoremap <buffer> <C-W>c <Cmd>UndotreeHide<CR>
