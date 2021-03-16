return { setup = function()
	vim.api.nvim_command[[command! Sterminal split term://$SHELL]]
	vim.api.nvim_command[[command! Vterminal vsplit term://$SHELL]]
end }
