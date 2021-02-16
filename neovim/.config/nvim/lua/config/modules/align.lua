return {
	packages = function(paq)
		paq{ 'junegunn/vim-easy-align', opt = true }
	end,
	config = function()
		vim.api.nvim_command'packadd vim-easy-align'

		local keymap_opts = { silent = true }
		vim.api.nvim_set_keymap('x', 'gl', '<Plug>(EasyAlign)', keymap_opts)
		vim.api.nvim_set_keymap('n', 'gl', '<Plug>(EasyAlign)', keymap_opts)
	end,
}
