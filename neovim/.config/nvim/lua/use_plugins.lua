return {setup = function()
	local packer = require'packer'
	packer.init{compile_path = vim.fn.stdpath('data')..'/packer_load.vim'}
	packer.reset()
	local use = require'packer'.use

	use {
		'wbthomason/packer.nvim',
		cmd = {'PackerClean', 'PackerCompile', 'PackerInstall', 'PackerSync', 'PackerUpdate'},
		config = function() require'use_plugins'.setup() end,
	}

	use {
		'antoinemadec/FixCursorHold.nvim',
		config = function() vim.g.cursorhold_updatetime = 100 end,
	}

	use 'tpope/vim-repeat'

	use 'inkarkat/vim-visualrepeat'

	use 'ryvnf/readline.vim'

	use 'kevinhwang91/nvim-bqf'

	use 'chaoren/vim-wordmotion'

	use {
		'tommcdo/vim-lion',
		config = function() vim.g.lion_squeeze_spaces = 1 end,
	}

	use 'tpope/vim-abolish'

	use 'tpope/vim-eunuch'

	use 'tpope/vim-vinegar'

	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require'nvim-treesitter.configs'.setup {
				ensure_installed = "maintained",
				highlight = {enable = true},
			}
		end,
	}

	use {
		'morhetz/gruvbox',
		config = function()
			vim.o.background = 'dark'
			vim.o.termguicolors = true
			vim.g.gruvbox_bold = 1
			vim.g.gruvbox_italic = 1
			vim.g.gruvbox_transparent_bg = 1
			vim.g.gruvbox_underline = 1
			vim.g.gruvbox_undercurl = 1
			vim.g.gruvbox_termcolors = 256
			vim.g.gruvbox_contrast_dark = 'medium'
			vim.g.gruvbox_contrast_light = 'medium'
			vim.g.gruvbox_italicize_comments = 1
			vim.g.gruvbox_italicize_strings = 1
			vim.g.gruvbox_invert_selection = 0
			vim.g.gruvbox_invert_signs = 0
			vim.g.gruvbox_invert_indent_guides = 0
			vim.g.gruvbox_invert_tabline = 0
			vim.g.gruvbox_improved_strings = 1
			vim.g.gruvbox_improved_warnings = 1
			vim.g.gruvbox_guisp_fallback = 1
			vim.cmd [[colorscheme gruvbox]]
		end,
	}

	use {
		'itchyny/lightline.vim',
		config = function()
			vim.g.lightline = {
				colorscheme = vim.g.colors_name,
				tabline = {right = {}}
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
		keys = '<Leader>f',
		config = function()
			local actions = require('telescope.actions')
			require('telescope').setup{defaults = {mappings = {i = {["<C-W>c"] = actions.close}}}}
			vim.fn.nvim_set_keymap('n', '<Leader>f', "<Cmd>lua require'telescope.builtin'.find_files{ hidden = true }<CR>", { noremap=true, silent=true })
		end,
	}

	use 'rust-lang/rust.vim'

	use {
		'ziglang/zig.vim',
		config = function() vim.g.zig_fmt_autosave = 0 end,
	}

	use {
		'blackCauldron7/surround.nvim',
		config = function() require'surround'.setup{} end,
	}

	use 'b3nj5m1n/kommentary'

	use {
		'TimUntersberger/neogit',
		cmd = 'Neogit',
		keys = '<Leader>g',
		config = function()
			vim.api.nvim_set_keymap('n', '<Leader>g', '<cmd>lua require"neogit".status.create"split"<CR>', {noremap = true, silent = true})
		end,
	}

	use {
		'lewis6991/gitsigns.nvim',
		requires = 'nvim-lua/plenary.nvim',
		config = function()
			require('gitsigns').setup {
				signs = {
					add          = {hl = 'GitGutterAdd'   , text = '+'},
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
			vim.api.nvim_set_keymap('n', '<Leader>u', '<cmd>UndotreeShow|UndotreeFocus<CR>', {noremap = true, silent = true})
		end,
	}

end}
