function personal_ctags()
	if not pcall(function() return vim.bo.tags end) or vim.bo.tags:len() == 0 then vim.bo.tags = vim.o.tags end
	local status, path = pcall(function() return vim.bo.path end)
	if not status or path:len() == 0 then path = vim.o.path end
	vim.bo.tags = path:gsub('[^,]*,', function(capture)
		if vim.fn.isdirectory(capture) then
			return capture .. '/tags,'
		end
	end) .. vim.bo.tags
end
vim.cmd'autocmd BufEnter * lua personal_ctags()'
