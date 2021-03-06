return { setup = function()
	vim.api.nvim_command'packadd undotree'

	vim.g.undotree_WindowLayout = 4
	vim.api.nvim_set_keymap('n', '<Leader>u', '<Cmd>UndotreeShow | UndotreeFocus<CR>', { noremap = true, silent = true })
	vim.api.nvim_exec([[
	augroup custom_undotree
	autocmd!
	autocmd FileType undotree nnoremap <silent> <buffer> <C-w>c <cmd>UndotreeHide<CR>
	augroup END
	]], false)
end }
