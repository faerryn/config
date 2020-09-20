function sync_lightline_colorscheme()
	vim.g.lightline = { tabline = { right = {} }, colorscheme = vim.g.colors_name or 'default' }
	vim.fn['lightline#enable']()
end
vim.cmd'autocmd VimEnter,ColorScheme * lua sync_lightline_colorscheme()'
