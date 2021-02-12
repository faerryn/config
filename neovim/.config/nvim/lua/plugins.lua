local install_path = vim.fn.stdpath'data'..'/site/pack/packer/opt/packer.nvim'
local compile_path = vim.fn.stdpath'data'..'/packer_load.vim'

local function setup()
	local packer = require'packer'
	packer.init{compile_path = compile_path}
	packer.reset()
	local use = require'packer'.use

	use {
		'wbthomason/packer.nvim',
		cmd = {'PackerClean', 'PackerCompile', 'PackerInstall', 'PackerSync', 'PackerUpdate'},
		config = function() require'plugins'.setup() end,
	}

	use {
		'dstein64/vim-startuptime',
		cmd = 'StartupTime',
	}

	use {
		'antoinemadec/FixCursorHold.nvim',
		config = function() vim.g.cursorhold_updatetime = 100 end,
	}

	use 'tpope/vim-repeat'

	use 'inkarkat/vim-visualrepeat'

	use {
		'ryvnf/readline.vim',
		event = 'CmdlineEnter *',
	}

	use 'chaoren/vim-wordmotion'

	use {
		'tommcdo/vim-lion',
		keys = {'gl', 'gL', {'v', 'gl'}, {'v', 'gL'}},
		config = function() vim.g.lion_squeeze_spaces = 1 end,
	}

	use {
		'tpope/vim-abolish',
		cmd = {'Abolish', 'Subvert', 'S'},
		keys = 'cr',
	}

	use 'tpope/vim-eunuch'

	use {
		'stsewd/gx-extended.vim',
		keys = {'gx', {'v', 'gx'}},
	}

	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require'nvim-treesitter.configs'.setup{
				ensure_installed = "maintained",
				highlight = {enable = true},
			}
		end,
	}

	use {
		'morhetz/gruvbox',
		config = function()
			vim.o.background    = 'dark'
			vim.o.termguicolors = true
			vim.g.gruvbox_bold                 = 1
			vim.g.gruvbox_italic               = 1
			vim.g.gruvbox_transparent_bg       = 1
			vim.g.gruvbox_underline            = 1
			vim.g.gruvbox_undercurl            = 1
			vim.g.gruvbox_termcolors           = 256
			vim.g.gruvbox_contrast_dark        = 'medium'
			vim.g.gruvbox_contrast_light       = 'medium'
			vim.g.gruvbox_italicize_comments   = 1
			vim.g.gruvbox_italicize_strings    = 1
			vim.g.gruvbox_invert_selection     = 0
			vim.g.gruvbox_invert_signs         = 0
			vim.g.gruvbox_invert_indent_guides = 0
			vim.g.gruvbox_invert_tabline       = 0
			vim.g.gruvbox_improved_strings     = 1
			vim.g.gruvbox_improved_warnings    = 1
			vim.g.gruvbox_guisp_fallback       = 1
			vim.api.nvim_command'colorscheme gruvbox'
		end,
	}

	use {
		'itchyny/lightline.vim',
		config = function()
			vim.g.lightline = {
				colorscheme = vim.g.colors_name,
				active = {
					left = {
						{'mode', 'paste'},
						{'readonly', 'filename', 'modified'},
					},
					right = {
						{'lineinfo'},
						{'percent'},
						{'fileformat', 'fileencoding', 'filetype'},
					},
				},
				inactive = {
					left = {{'filename'}},
					right = {
						{'lineinfo'},
						{'percent'},
					},
				},
				tabline = {
					left = {{'tabs'}},
					right = {},
				},
			}
			vim.api.nvim_exec([[
			augroup lightline_colorscheme_sync
			autocmd!
			autocmd ColorScheme * let g:lightline.colorscheme = g:colors_name | call lightline#enable()
			augroup END
			]], false)
		end
	}

	use {
		'nvim-telescope/telescope.nvim',
		requires = {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'},
		cmd = 'Telescope',
		keys = {'<Leader>ff', '<Leader>fb', '<Leader>fg', '<Leader>ft'},
		config = function()
			local actions = require('telescope.actions')
			require('telescope').setup{defaults = {mappings = {i = {["<C-W>c"] = actions.close}}}}
			local keymap_opts = {noremap = true, silent = true}
			vim.fn.nvim_set_keymap('n', '<Leader>ff', "<Cmd>lua require'telescope.builtin'.fd{hidden = true}<CR>", keymap_opts)
			vim.fn.nvim_set_keymap('n', '<Leader>fb', "<Cmd>lua require'telescope.builtin'.buffers()<CR>",         keymap_opts)
			vim.fn.nvim_set_keymap('n', '<Leader>fg', "<Cmd>lua require'telescope.builtin'.treesitter()<CR>",      keymap_opts)
			vim.fn.nvim_set_keymap('n', '<Leader>ft', "<Cmd>lua require'telescope.builtin'.builtin()<CR>",         keymap_opts)
		end,
	}

	use {
		'rust-lang/rust.vim',
		ft = 'rust',
	}

	use {
		'ziglang/zig.vim',
		config = function()
			vim.g.zig_fmt_autosave = 0
		end,
	}

	use {
		'machakann/vim-sandwich',
		keys = {'sa', 'sd', 'sr', {'v', 'sa'}},
		config = function()
			local plug = vim.api.nvim_eval[["\<Plug>"]]
			vim.g['sandwich#recipes'] = {
				{buns = {'(', ')'}, nesting = -1, linewise = 0, input = {'(', ')', 'b'}},
				{buns = {'{', '}'}, nesting = -1, linewise = 0, input = {'{', '}', 'B'}},
				{buns = {'[', ']'}, nesting = -1, linewise = 0, input = {'(', ')'}},
				{buns = {'<', '>'}, nesting = -1, linewise = 0, input = {'<', '>'}},
				{buns = 'sandwich#magicchar#t#tag()', listexpr = 1, kind = {'add', 'replace'}, action = {'add'}, input = {'t'}},
				{external = {plug..'(textobj-sandwich-tag-i)', plug..'(textobj-sandwich-tag-a)'}, noremap = 0, kind = {'replace', 'query'}, expr_filter = {'operator#sandwich#kind() ==# "replace"'}, synchro = 1, input = {'t'}},
				{external = {plug..'(textobj-sandwich-tag-i)', plug..'(textobj-sandwich-tag-a)'}, noremap = 0, kind = {'delete', 'textobj'}, expr_filter = {'operator#sandwich#kind() !=# "replace"'}, synchro = 1, linewise = 1, input = {'t'}},
			}
			vim.g.sandwich_no_default_key_mappings          = 1
			vim.g.operator_sandwich_no_default_key_mappings = 1
			vim.g.textobj_sandwich_no_default_key_mappings  = 1
			local keymap_opts = {silent = true}
			vim.api.nvim_set_keymap('n', 'sa', '<Plug>(operator-sandwich-add)', keymap_opts)
			vim.api.nvim_set_keymap('v', 'sa', '<Plug>(operator-sandwich-add)', keymap_opts)
			vim.api.nvim_set_keymap('n', 'sd', '<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)', keymap_opts)
			vim.api.nvim_set_keymap('n', 'sr', '<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)', keymap_opts)
		end,
	}

	use {
		'windwp/nvim-autopairs',
		config = function() require'nvim-autopairs'.setup() end
	}

	use {
		'b3nj5m1n/kommentary',
		keys = {'gc', 'gcc', {'v', 'gc'}},
	}

	use {
		'norcalli/nvim-colorizer.lua',
		config = function()
			vim.api.nvim_exec([[
			augroup nvim-colorizer_attach
			autocmd!
			autocmd BufEnter * lua require'colorizer'.attach_to_buffer()
			augroup END
			]], false)
		end,
	}

	use {
		'TimUntersberger/neogit',
		cmd = 'Neogit',
		keys = '<Leader>g',
		config = function()
			vim.api.nvim_set_keymap('n', '<Leader>g', '<Cmd>lua require"neogit".status.create"split"<CR>', {noremap = true, silent = true})
		end,
	}

	use {
		'lewis6991/gitsigns.nvim',
		requires = 'nvim-lua/plenary.nvim',
		config = function()
			require('gitsigns').setup{
				signs = {
					add          = {hl = 'GitGutterAdd',    text = '+'},
					change       = {hl = 'GitGutterChange', text = '~'},
					delete       = {hl = 'GitGutterDelete', text = '_'},
					topdelete    = {hl = 'GitGutterDelete', text = '‾'},
					changedelete = {hl = 'GitGutterChange', text = '~'},
				}
			}
		end,
	}

	use {
		'mbbill/undotree',
		cmd = { 'UndotreeFocus', 'UndotreeHide', 'UndotreeShow', 'UndotreeToggle' },
		keys = '<Leader>u',
		config = function()
			vim.g.undotree_WindowLayout = 4
			vim.api.nvim_set_keymap('n', '<Leader>u', '<Cmd>UndotreeShow | UndotreeFocus<CR>', {noremap = true, silent = true})
		end,
	}

end

return {
	setup = setup,
	install_path = install_path,
	compile_path = compile_path,
}
