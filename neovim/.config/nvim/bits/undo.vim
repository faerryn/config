set undofile
nnoremap <silent> <Leader>u <Cmd>UndotreeShow<CR><Cmd>UndotreeFocus<CR><Cmd>set ft=undotree<CR>
let g:undotree_CustomUndotreeCmd='vertical 35 new'
let g:undotree_CustomDiffpanelCmd='"'
let g:undotree_HelpLine=0
autocmd FileType undotree nnoremap <silent> <buffer> <Esc> <Cmd>UndotreeHide<CR>
autocmd FileType undotree nnoremap <silent> <buffer> <C-W>c <Cmd>UndotreeHide<CR>