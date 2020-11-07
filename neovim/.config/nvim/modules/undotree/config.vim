let g:undotree_CustomUndotreeCmd  = 'new'
let g:undotree_CustomDiffpanelCmd = '"'
let g:undotree_HelpLine           = 0

packadd undotree

nnoremap <silent> <Leader>u <Cmd>call undotree#UndotreeShow()<Bar>call undotree#UndotreeFocus()<Bar>setlocal filetype=undotree<CR>
autocmd Personal FileType undotree nnoremap <silent> <buffer> <Esc> <Cmd>call undotree#UndotreeHide()<CR>
