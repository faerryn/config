return { setup = function()
	vim.api.nvim_command'packadd zig.vim'
	vim.g.zig_fmt_autosave = 0
end }
