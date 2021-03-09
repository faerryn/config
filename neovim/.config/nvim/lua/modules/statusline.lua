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

	vim.api.nvim_exec([[
	augroup custom_lightline
	autocmd!
	autocmd ColorScheme * let g:lightline.colorscheme = g:colors_name | call lightline#enable()
	augroup END
	]], false)

	vim.fn['lightline#enable']()
end }
