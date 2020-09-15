set undodir=$XDG_CACHE_HOME/nvim/undo
set undofile
nnoremap <silent> <Leader>u <cmd>UndotreeShow<CR><cmd>UndotreeFocus<CR><cmd>set filetype=undotree<CR>
let g:undotree_CustomUndotreeCmd = 'new'
let g:undotree_CustomDiffpanelCmd = '"'
let g:undotree_HelpLine = 0
autocmd FileType undotree nnoremap <silent> <buffer> <Esc> <cmd>UndotreeHide<CR>
autocmd FileType undotree nnoremap <silent> <buffer> <C-W>c <cmd>UndotreeHide<CR>
