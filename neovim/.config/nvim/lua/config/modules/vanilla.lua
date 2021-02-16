return {
	packages = function(paq)
		paq{ 'antoinemadec/FixCursorHold.nvim', opt = true }
		paq{ 'tpope/vim-repeat', opt = true }
		paq{ 'ryvnf/readline.vim', opt = true }
		paq{ 'stsewd/gx-extended.vim', opt = true }
	end,
	config = function()
		-- FixCursorHold.nvim
		vim.api.nvim_command'packadd FixCursorHold.nvim'
		vim.g.cursorhold_updatetime = 1000

		-- vim-repeat
		vim.api.nvim_command'packadd vim-repeat'

		-- readline.vim
		vim.api.nvim_command'packadd readline.vim'

		-- gx-extended.nvim
		vim.api.nvim_command'packadd gx-extended.vim'
		vim.g['gxext#handler'] = { global = { 'global#urls' } }
	end,
}
