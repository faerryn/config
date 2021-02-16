return {
	packages = function(paq)
		paq{ 'ziglang/zig.vim', opt = true }
	end,
	config = function()
		vim.api.nvim_command'packadd zig.vim'

		vim.g.zig_fmt_autosave = 0
	end,
}
