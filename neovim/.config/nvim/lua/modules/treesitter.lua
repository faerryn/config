return { setup = function()
	vim.api.nvim_command'packadd nvim-treesitter'
	vim.api.nvim_command'packadd nvim-treesitter-textobjects'

	require'nvim-treesitter.configs'.setup{
		highlight = { enable = true },
		textobjects = {
			select = {
				enable = true,
				keymaps = {
					['af'] = '@function.outer',
					['if'] = '@function.inner',
					['ac'] = '@class.outer',
					['ic'] = '@class.inner',
				},
			},
			move = {
				enable = true,
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
		},
	}
end }
