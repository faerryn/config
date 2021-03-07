return { setup = function()
	vim.g.c_syntax_for_h = 1

	vim.api.nvim_command'packadd zig.vim'
	vim.g.zig_fmt_autosave = 0

	vim.api.nvim_exec([[
	augroup filetypes_format_command
	autocmd!
	autocmd FileType c,cpp command! Format %!clang-format
	autocmd FileType rust command! Format %!rustfmt
	autocmd FileType zig command! Format %!zig fmt --stdin
	augroup END
	]], false)
end }
