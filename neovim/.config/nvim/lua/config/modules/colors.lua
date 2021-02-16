return {
	packages = function(paq)
		paq{ 'norcalli/nvim-colorizer.lua', opt = true }
	end,
	config = function()
		vim.api.nvim_command'packadd nvim-colorizer.lua'

		vim.api.nvim_exec([[
		augroup nvim-colorizer_attach
		autocmd!
		autocmd BufEnter * lua require'colorizer'.attach_to_buffer()
		augroup END
		]], false)
	end,
}
