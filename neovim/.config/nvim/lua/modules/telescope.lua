return { setup = function()
	vim.api.nvim_command'packadd telescope.nvim'
	vim.api.nvim_command'packadd plenary.nvim'
	vim.api.nvim_command'packadd popup.nvim'
	vim.api.nvim_command'packadd telescope-fzy-native.nvim'

	require'telescope'.setup{ defaults = {
		mappings = { i = { ['<C-w>c'] = require'telescope.actions'.close } },
		file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
	} }

	require('telescope').load_extension('fzy_native')

	local keymap_opts = { noremap = true, silent = true }
	vim.fn.nvim_set_keymap('n', '<Leader>ff', [[<Cmd>lua require'telescope.builtin'.find_files{ hidden = true }<CR>]], keymap_opts)
	vim.fn.nvim_set_keymap('n', '<Leader>fl', [[<Cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find()<CR>]], keymap_opts)
end }
