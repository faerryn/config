vim.cmd'nnoremap <silent> <Leader>u <cmd>UndotreeShow<CR><cmd>UndotreeFocus<CR><cmd>set filetype=undotree<CR>'
vim.g.undotree_CustomUndotreeCmd  = 'new'
vim.g.undotree_CustomDiffpanelCmd = '"'
vim.g.undotree_HelpLine           = 0
vim.cmd'autocmd FileType undotree nnoremap <silent> <buffer> <Esc> <cmd>UndotreeHide<CR>'
vim.cmd'autocmd FileType undotree nnoremap <silent> <buffer> <C-W>c <cmd>UndotreeHide<CR>'
