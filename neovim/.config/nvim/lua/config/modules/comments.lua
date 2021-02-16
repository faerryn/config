return {
	packages = function(paq)
		paq { 'b3nj5m1n/kommentary', opt = true }
	end,
	config = function()
		vim.api.nvim_command'packadd kommentary'
	end
}
