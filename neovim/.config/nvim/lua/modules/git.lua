return { setup = function()
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
		},
		keymaps = {},
	}
end }
