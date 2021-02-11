local actions = require('telescope.actions')
require('telescope').setup{
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close
			},
		},
	}
}

vim.fn.nvim_set_keymap('n', '<Leader>f', "<Cmd>lua require'telescope.builtin'.find_files{ find_command = { 'fd', '--type', 'file', '--hidden', '--ignore-file', os.getenv'XDG_CONFIG_HOME'..'/git/ignore' } }<CR>", { noremap=true, silent=true })
