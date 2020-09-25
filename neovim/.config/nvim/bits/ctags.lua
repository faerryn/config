function personal_ctags()
	local status, path = pcall(function () return vim.bo.path end)
	if not status then path = vim.o.path end
	vim.bo.tags = path:gsub('[^,]*', function(capture)
		if capture:len() > 0 then return capture .. '/tags' end
	end):gsub(',+', ','):gsub('[^,]$', ',') .. vim.o.tags
end
vim.cmd'autocmd BufRead * lua personal_ctags()'
