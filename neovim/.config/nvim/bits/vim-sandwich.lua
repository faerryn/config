vim.g['sandwich#recipes'] = {
	{ buns = {'(', ')'}, nesting = -1, linewise = 0, input = {'(', ')', 'h', 'b'} },
	{ buns = {'{', '}'}, nesting = -1, linewise = 0, input = {'{', '}', 'j', 'B'} },
	{ buns = {'[', ']'}, nesting = -1, linewise = 0, input = {'[', ']', 'k'} },
	{ buns = {'<', '>'}, nesting = -1, linewise = 0, input = {'<', '>', 'l'} },
}
vim.g.sandwich_no_default_key_mappings          = 1
vim.g.operator_sandwich_no_default_key_mappings = 1
vim.g.textobj_sandwich_no_default_key_mappings  = 1
