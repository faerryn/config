return { setup = function()
	-- neogit
	-- vim.api.nvim_command'packadd neogit'
	-- vim.api.nvim_set_keymap('n', '<Leader>g', [[<Cmd>lua require'neogit'.status.create'split'<CR>]], { noremap = true, silent = true })

	-- neogit
	vim.api.nvim_command'packadd vim-fugitive'
	vim.api.nvim_set_keymap('n', '<Leader>g', '<Cmd>Git<CR>', { noremap = true, silent = true })

	-- gitsigns.nvim
	vim.api.nvim_command'packadd gitsigns.nvim'
	vim.api.nvim_command'packadd plenary.nvim'

	require('gitsigns').setup{
		signs = {
			add          = { hl = 'GitGutterAdd',    text = '+' },
			change       = { hl = 'GitGutterChange', text = '~' },
			delete       = { hl = 'GitGutterDelete', text = '_' },
			topdelete    = { hl = 'GitGutterDelete', text = '‾' },
			changedelete = { hl = 'GitGutterChange', text = '~' },
		}
	}
end }
