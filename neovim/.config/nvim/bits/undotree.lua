vim.g.undotree_CustomUndotreeCmd  = 'new'
vim.g.undotree_CustomDiffpanelCmd = '"'
vim.g.undotree_HelpLine           = 0

function personal_undotree()
	vim.cmd'UndotreeShow'
	vim.cmd'UndotreeFocus'
	vim.bo.filetype = 'undotree'
end
