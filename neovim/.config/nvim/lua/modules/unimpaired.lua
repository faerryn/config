return { setup = function()
	local keymap_opts = { noremap = true, silent = true }

	vim.api.nvim_set_keymap('n', 'Y', 'y$', keymap_opts)

	vim.api.nvim_set_keymap('n', ']a', '<Cmd>next<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', '[a', '<Cmd>previous<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', ']A', '<Cmd>last<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', '[A', '<Cmd>first<CR>', keymap_opts)

	vim.api.nvim_set_keymap('n', ']b', '<Cmd>bnext<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', '[b', '<Cmd>bprevious<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', ']B', '<Cmd>blast<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', '[B', '<Cmd>bfirst<CR>', keymap_opts)

	vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>lopen<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', '<Leader>q', '<Cmd>copen<CR>', keymap_opts)

	vim.api.nvim_set_keymap('n', ']q', '<Cmd>cnext<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', '[q', '<Cmd>cprevious<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', ']Q', '<Cmd>clast<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', '[Q', '<Cmd>cfirst<CR>', keymap_opts)

	vim.api.nvim_set_keymap('n', ']l', '<Cmd>lnext<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', '[l', '<Cmd>lprevious<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', ']L', '<Cmd>llast<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', '[L', '<Cmd>lfirst<CR>', keymap_opts)
end }
