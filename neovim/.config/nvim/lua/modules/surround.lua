return { setup = function()
	vim.api.nvim_command'packadd vim-sandwich'

	local plug = vim.api.nvim_eval[["\<Plug>"]]
	vim.g['sandwich#recipes'] = {
		{ buns = { '(', ')' }, nesting = -1, linewise = 0, input = { '(', ')', 'b' } },
		{ buns = { '{', '}' }, nesting = -1, linewise = 0, input = { '{', '}', 'B' } },
		{ buns = { '[', ']' }, nesting = -1, linewise = 0, input = { '[', ']' } },
		{ buns = { '<', '>' }, nesting = -1, linewise = 0, input = { '<', '>' } },
		{ buns = 'sandwich#magicchar#t#tag()', listexpr = 1, kind = { 'add', 'replace' }, action = { 'add' }, input = { 't' } },
		{
			external = { plug..'(textobj-sandwich-tag-i)', plug..'(textobj-sandwich-tag-a)' },
			noremap = 0,
			kind = { 'replace', 'query' },
			expr_filter = { [[operator#sandwich#kind() ==# 'replace']] },
			synchro = 1,
			input = { 't' }
		},
		{
			external = { plug..'(textobj-sandwich-tag-i)', plug..'(textobj-sandwich-tag-a)' },
			noremap = 0,
			kind = { 'delete', 'textobj' },
			expr_filter = { [[operator#sandwich#kind() !=# 'replace']] },
			synchro = 1,
			linewise = 1,
			input = { 't' }
		},
		{ buns = 'sandwich#magicchar#i#input("operator")', kind = { 'add', 'replace' }, action = { 'add' }, listexpr = 1, input = { 'i' } },
		{ buns = 'sandwich#magicchar#i#input("textobj", 1)', kind = { 'delete', 'replace', 'query' }, listexpr = 1, regex = 1, input = { 'i' } },
	}

	vim.g.sandwich_no_default_key_mappings = 1
	vim.g.textobj_sandwich_no_default_key_mappings = 1
	vim.g.operator_sandwich_no_default_key_mappings = 1

	-- disable s as to not conflict with sandwich bindings
	local keymap_opts = { silent = true }
	vim.api.nvim_set_keymap('n', 's', '', keymap_opts)
	vim.api.nvim_set_keymap('v', 's', '', keymap_opts)

	vim.api.nvim_set_keymap('n', 'sa', '<Plug>(operator-sandwich-add)', keymap_opts)
	vim.api.nvim_set_keymap('x', 'sa', '<Plug>(operator-sandwich-add)', keymap_opts)
	vim.api.nvim_set_keymap('o', 'sa', '<Plug>(operator-sandwich-g@)', keymap_opts)

	vim.api.nvim_set_keymap('n', 'sd', '<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)', keymap_opts)
	vim.api.nvim_set_keymap('x', 'sd', '<Plug>(operator-sandwich-delete)', keymap_opts)

	vim.api.nvim_set_keymap('n', 'sr', '<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)', keymap_opts)
	vim.api.nvim_set_keymap('x', 'sr', '<Plug>(operator-sandwich-replace)', keymap_opts)

	vim.api.nvim_set_keymap('o', 'is', '<Plug>(textobj-sandwich-query-i)', keymap_opts)
	vim.api.nvim_set_keymap('x', 'is', '<Plug>(textobj-sandwich-query-i)', keymap_opts)
	vim.api.nvim_set_keymap('o', 'as', '<Plug>(textobj-sandwich-query-a)', keymap_opts)
	vim.api.nvim_set_keymap('x', 'as', '<Plug>(textobj-sandwich-query-a)', keymap_opts)
end }
