return {
	packages = function(paq)
		paq{ 'nvim-treesitter/nvim-treesitter', opt = true }
	end,
	config = function()
		vim.api.nvim_command'packadd nvim-treesitter'
		require'nvim-treesitter.configs'.setup{
			highlight = { enable = true },
		}
	end,
}
