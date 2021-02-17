return { setup = function()
	vim.api.nvim_command'packadd nvim-treesitter'
	require'nvim-treesitter.configs'.setup{ highlight = { enable = true } }
end }
