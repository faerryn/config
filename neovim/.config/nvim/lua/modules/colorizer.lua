return { setup = function()
	vim.api.nvim_command'packadd nvim-colorizer.lua'

	vim.api.nvim_exec([[
	augroup custom_nvim-colorizer
	autocmd!
	autocmd BufEnter * lua require'colorizer'.attach_to_buffer()
	augroup END
	]], false)
end }
