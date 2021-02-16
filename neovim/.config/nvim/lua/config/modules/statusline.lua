return {
	packages = function(paq)
		paq{ 'itchyny/lightline.vim', opt = true }
	end,
	config = function()
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
		augroup lightline_colorscheme_sync
		autocmd!
		autocmd ColorScheme * lua local tmp = vim.g.lightline; tmp.colorscheme = vim.g.colors_name; vim.g.lightline = tmp; vim.fn['lightline#enable']()
		"autocmd ColorScheme * lua vim.g.lightline.colorscheme = vim.g.colors_name; vim.fn['lightline#enable']()
		augroup END
		]], false)

		vim.fn['lightline#enable']()
	end
}

