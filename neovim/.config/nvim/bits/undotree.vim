nnoremap <Leader>u :UndotreeShow<CR>:UndotreeFocus<CR>:set ft=undotree<CR>
let g:undotree_CustomUndotreeCmd='split'
let g:undotree_CustomDiffpanelCmd='"'
let g:undotree_HelpLine=0
autocmd FileType undotree nnoremap <buffer> <Esc> :UndotreeHide<CR>
autocmd FileType undotree nnoremap <buffer> <C-W>c :UndotreeHide<CR>
