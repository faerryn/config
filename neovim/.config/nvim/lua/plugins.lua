local packer_config = {
	compile_path = vim.fn.stdpath'data'..'/packer_compiled.vim',
	auto_clean = false,
	disable_commands = true,
}

local function plugins()
	local packer = require'packer'
	packer.init(packer_config)
	packer.reset()

	local use = packer.use

	use {
		'wbthomason/packer.nvim',
		require = 'nvim-lua/plenary.nvim',
		cmd = { 'PackerClean', 'PackerCompile', 'PackerInstall', 'PackerSync', 'PackerUpdate' },
		config = function()
			vim.api.nvim_exec([[
			command! PackerInstall lua require'plenary.reload'.reload_module'plugins'; require'plugins'.plugins(); require('packer').install()
			command! PackerUpdate  lua require'plenary.reload'.reload_module'plugins'; require'plugins'.plugins(); require('packer').update()
			command! PackerSync    lua require'plenary.reload'.reload_module'plugins'; require'plugins'.plugins(); require('packer').sync()
			command! PackerClean   lua require'plenary.reload'.reload_module'plugins'; require'plugins'.plugins(); require('packer').clean()
			command! PackerCompile lua require'plenary.reload'.reload_module'plugins'; require'plugins'.plugins(); require('packer').compile()
			]], false)
		end,
	}

	use {
		'dstein64/vim-startuptime',
		cmd = 'StartupTime',
	}

	use {
		'antoinemadec/FixCursorHold.nvim',
		config = function() vim.g.cursorhold_updatetime = 100 end,
	}

	use {
		'tpope/vim-repeat',
		keys = '.',
	}

	use {
		'ryvnf/readline.vim',
		event = 'CmdlineEnter *',
	}

	use {
		'junegunn/vim-easy-align',
		cmd = 'EasyAlign',
		keys = { 'gl', { 'x', 'gl' } },
		config = function()
			local keymap_opts = { silent = true }
			vim.api.nvim_set_keymap('x', 'gl', '<Plug>(EasyAlign)', keymap_opts)
			vim.api.nvim_set_keymap('n', 'gl', '<Plug>(EasyAlign)', keymap_opts)
		end,
	}

	use {
		'stsewd/gx-extended.vim',
		keys = { 'gx', { 'v', 'gx' } },
		config = function() vim.g['gxext#handler'] = { global = { 'global#urls' } } end,
	}

	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require'nvim-treesitter.configs'.setup{
				highlight = { enable = true },
			}
		end,
	}

	use {
		'neovim/nvim-lspconfig',
		config = function()
			local lspconfig = require'lspconfig'

			local servers = { 'clangd' }

			local on_attach = function(client, bufnr)
				vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
				local keymap_opts = { noremap = true, silent = true }
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>',  keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',  '<Cmd>lua vim.lsp.buf.hover()<CR>',       keymap_opts)
			end

			vim.api.nvim_command'command! LspRename lua vim.lsp.buf.rename()'

			for _, server in ipairs(servers) do
				lspconfig[server].setup{ on_attach = on_attach }
			end
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
				active = {
					left = {
						{ 'mode', 'paste' },
						{ 'readonly', 'filename', 'modified' },
					},
					right = {
						{ 'lineinfo' },
						{ 'percent' },
						{ 'fileformat', 'fileencoding', 'filetype' },
					},
				},
				inactive = {
					left = { {'filename' } },
					right = {
						{ 'lineinfo' },
						{ 'percent' },
					},
				},
				tabline = {
					left = { {'tabs' } },
					right = { },
				},
			}

			vim.api.nvim_exec([[
			augroup lightline_colorscheme_sync
			autocmd!
			autocmd ColorScheme * lua local tmp = vim.g.lightline; tmp.colorscheme = vim.g.colors_name; vim.g.lightline = tmp; vim.fn['lightline#enable']()
			"autocmd ColorScheme * lua vim.g.lightline.colorscheme = vim.g.colors_name; vim.fn['lightline#enable']()
			augroup END
			]], false)
		end
	}

	use {
		'nvim-telescope/telescope.nvim',
		requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' },
		cmd = 'Telescope',
		keys = { '<Leader>ff', '<Leader>fl' },
		config = function()
			require'telescope'.setup{ defaults = {
				mappings = { i = { ['<C-w>c'] = require'telescope.actions'.close } },
				file_previewer = require'telescope.previewers'.vim_buffer_cat.new
			} }
			local keymap_opts = { noremap = true, silent = true }
			vim.fn.nvim_set_keymap('n', '<Leader>ff', [[<Cmd>lua require'telescope.builtin'.find_files{ hidden = true }<CR>]], keymap_opts)
			vim.fn.nvim_set_keymap('n', '<Leader>fl', [[<Cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find()<CR>]], keymap_opts)
		end,
	}

	use {
		'ziglang/zig.vim',
		config = function()
			vim.g.zig_fmt_autosave = 0
		end,
	}

	use {
		'machakann/vim-sandwich',
		keys = { 'sa', 'sd', 'sr', { 'v', 'sa' } },
		config = function()
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
			vim.g.operator_sandwich_no_default_key_mappings = 1
			vim.g.textobj_sandwich_no_default_key_mappings  = 1
		end,
	}

	use {
		'b3nj5m1n/kommentary',
		keys = { 'gc', 'gcc', { 'v', 'gc' } },
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
			vim.api.nvim_set_keymap('n', '<Leader>g', [[<Cmd>lua require'neogit'.status.create'split'<CR>]], { noremap = true, silent = true })
		end,
	}

	use {
		'lewis6991/gitsigns.nvim',
		requires = 'nvim-lua/plenary.nvim',
		event = 'BufRead *',
		config = function()
			require('gitsigns').setup{
				signs = {
					add          = { hl = 'GitGutterAdd',    text = '+' },
					change       = { hl = 'GitGutterChange', text = '~' },
					delete       = { hl = 'GitGutterDelete', text = '_' },
					topdelete    = { hl = 'GitGutterDelete', text = '‾' },
					changedelete = { hl = 'GitGutterChange', text = '~' },
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
			vim.api.nvim_set_keymap('n', '<Leader>u', '<Cmd>UndotreeShow | UndotreeFocus<CR>', { noremap = true, silent = true })
			vim.api.nvim_exec([[
			augroup undotree_remap
			autocmd!
			autocmd FileType undotree nnoremap <silent> <buffer> <C-w>c <cmd>UndotreeHide<CR>
			augroup END
			]], false)
		end,
	}

end

local function bootstrap()
	local install_path = vim.fn.stdpath'data'..'/site/pack/packer/opt/packer.nvim'
	if vim.fn.empty(vim.fn.glob(install_path)) == 1 then
		vim.fn.system('git clone --depth 1 https://github.com/wbthomason/packer.nvim.git '..install_path)
	end
	vim.api.nvim_command'packadd packer.nvim'

	plugins()

	local packer = require'packer'
	packer.install()
	packer.compile()
end

local function setup()
	vim.api.nvim_command('silent! source '..packer_config.compile_path)
	if packer_plugins == nil then bootstrap() end
end

return {
	setup = setup,
	plugins = plugins,
}
