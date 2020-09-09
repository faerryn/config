set undofile
nnoremap <Leader>u <Cmd>UndotreeShow<CR><Cmd>UndotreeFocus<CR><Cmd>set ft=undotree<CR>
let g:undotree_CustomUndotreeCmd='split'
let g:undotree_CustomDiffpanelCmd='"'
let g:undotree_HelpLine=0
autocmd FileType undotree nnoremap <buffer> <Esc> <Cmd>UndotreeHide<CR>
autocmd FileType undotree nnoremap <buffer> <C-W>c <Cmd>UndotreeHide<CR>
