function personal_lastline()
	local lastline = vim.fn.line"'\""
	if lastline > 0 and lastline < vim.fn.line'$' then
		vim.api.nvim_win_set_cursor(0, {lastline , 0 })
	end
end
vim.cmd'autocmd BufReadPost * lua personal_lastline()'
