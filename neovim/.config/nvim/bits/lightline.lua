function personal_lightline()
	vim.g.lightline = { tabline = { right = {} }, colorscheme = vim.g.colors_name or 'default' }
	vim.fn['lightline#enable']()
end
vim.cmd'autocmd VimEnter,ColorScheme * lua personal_lightline()'
