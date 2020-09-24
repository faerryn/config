function personal_ctags()
	vim.bo.tags = vim.fn.eval'&path':gsub('[^,]*', function(capture)
		if capture:len() > 0 then return capture .. '/tags,' end
	end):gsub(',+', ','):gsub(',$', '') .. ',tags'
end
vim.cmd'autocmd BufEnter * lua personal_ctags()'
