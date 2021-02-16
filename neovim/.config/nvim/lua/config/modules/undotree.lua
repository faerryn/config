return {
	packages = function(paq)
		paq { 'mbbill/undotree', opt = true }
	end,
	config = function()
		vim.api.nvim_command'packadd undotree'

		vim.g.undotree_WindowLayout = 4
		vim.api.nvim_set_keymap('n', '<Leader>u', '<Cmd>UndotreeShow | UndotreeFocus<CR>', { noremap = true, silent = true })
		vim.api.nvim_exec([[
		augroup undotree_remap
		autocmd!
		autocmd FileType undotree nnoremap <silent> <buffer> <C-w>c <cmd>UndotreeHide<CR>
		augroup END
		]], false)
	end,
}

