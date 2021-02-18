return { setup = function()
	vim.api.nvim_command'packadd lightline.vim'

	vim.g.lightline = {
		colorscheme = vim.g.colors_name,
		active = {
			left = {
				{ 'mode', 'paste' },
				{ 'readonly', 'filename', 'modified' },
			},
			right = {
				{ 'lineinfo' },
				{ 'percent' },
				{ 'fileformat', 'fileencoding', 'filetype' },
			},
		},
		inactive = {
			left = { {'filename' } },
			right = {
				{ 'lineinfo' },
				{ 'percent' },
			},
		},
		tabline = {
			left = { {'tabs' } },
			right = { },
		},
	}

	vim.api.nvim_command[[autocmd lightline ColorScheme * lua local tmp = vim.g.lightline; tmp.colorscheme = vim.g.colors_name; vim.g.lightline = tmp; vim.fn['lightline#enable']()]]
	-- vim.api.nvim_command[[autocmd lightline ColorScheme * lua vim.g.lightline.colorscheme = vim.g.colors_name; vim.fn['lightline#enable']()]]

	vim.fn['lightline#enable']()
end }
