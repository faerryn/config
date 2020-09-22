vim.g['sandwich#recipes'] = {
	{ buns = {'(', ')'}, nesting = -1, linewise = 0, input = {'(', ')', 'b'} },
	{ buns = {'{', '}'}, nesting = -1, linewise = 0, input = {'{', '}', 'B'} },
	{ buns = {'[', ']'}, nesting = -1, linewise = 0 },
	{ buns = {'<', '>'}, nesting = -1, linewise = 0 },
}
vim.g.sandwich_no_default_key_mappings          = 1
vim.g.operator_sandwich_no_default_key_mappings = 1
vim.g.textobj_sandwich_no_default_key_mappings  = 1
