return {
	packages = function(paq)
		paq { 'dstein64/vim-startuptime', opt = true }
	end,
	config = function()
		vim.api.nvim_command'packadd vim-startuptime'
	end,
}
