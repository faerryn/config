function use_packages(use)
	use {
		'wbthomason/packer.nvim',
		cmd = {'PackerClean', 'PackerCompile', 'PackerInstall', 'PackerSync', 'PackerUpdate'},
		config = function()
			local packer = require'packer'
			local compile_path = vim.fn.stdpath('data')..'/packer_load.vim'
			packer.init{compile_path = compile_path}
			packer.reset()
			use_packages(packer.use)
		end,
	}

	use {
		'antoinemadec/FixCursorHold.nvim',
		config = function() vim.g.cursorhold_updatetime = 100 end,
	}

	use 'tommcdo/vim-lion'

	use 'tpope/vim-abolish'

	use 'tpope/vim-eunuch'

	use 'tpope/vim-vinegar'

	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require'nvim-treesitter.configs'.setup {
				ensure_installed = "all",
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
		'hoob3rt/lualine.nvim',
		config = function() require'lualine'.status() end,
	}

	use {
		'nvim-telescope/telescope.nvim',
		requires = {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'},
		cmd = 'Telescope',
		keys = '<Leader>f',
		config = function()
			local actions = require('telescope.actions')
			require('telescope').setup{defaults = {mappings = {i = {["<C-W>c"] = actions.close}}}}
			vim.fn.nvim_set_keymap('n', '<Leader>f', "<Cmd>lua require'telescope.builtin'.find_files{ find_command = { 'fd', '--type', 'file', '--hidden', '--ignore-file', os.getenv'XDG_CONFIG_HOME'..'/git/ignore' } }<CR>", { noremap=true, silent=true })
		end,
	}

	use {
		'neovim/nvim-lspconfig',
		ft = { 'c', 'cpp', 'rust', 'zig' },
		config = function()
			local nvim_lsp = require'lspconfig'
			local configs = require'lspconfig/configs'
			local servers = {'clangd', 'rust_analyzer', 'zls'}
			nvim_lsp.clangd.cmd = {'clangd', '--background-index', '--clang-tidy'}
			if not configs.zls then
				configs.zls = {
					default_config = {
						cmd = { 'zls' };
						filetypes = { 'zig' };
						root_dir = nvim_lsp.util.root_pattern('build.zig');
						settings = {};
					};
				}
			end
			local on_attach = function(client, bufnr)
				vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
				local keymap_opts = {noremap = true, silent = true}
				-- Mappings.
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',        '<cmd>lua vim.lsp.buf.declaration()<CR>',                                keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',        '<cmd>lua vim.lsp.buf.definition()<CR>',                                 keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',         '<cmd>lua vim.lsp.buf.hover()<CR>',                                      keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi',        '<cmd>lua vim.lsp.buf.implementation()<CR>',                             keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>',     '<cmd>lua vim.lsp.buf.signature_help()<CR>',                             keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',                       keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',                    keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D',  '<cmd>lua vim.lsp.buf.type_definition()<CR>',                            keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>',                                     keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',        '<cmd>lua vim.lsp.buf.references()<CR>',                                 keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>e',  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',               keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d',        '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',                           keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d',        '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',                           keymap_opts)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>q',  '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',                         keymap_opts)
				-- Set some keybinds conditional on server capabilities
				if client.resolved_capabilities.document_formatting then
					vim.api.nvim_exec([[
					augroup lsp_document_autoformat
					autocmd!
					autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
					augroup END
					]], false)
				end
				-- Set autocommands conditional on server_capabilities
				if client.resolved_capabilities.document_highlight then
					vim.api.nvim_exec([[
					hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
					hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
					hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
					augroup lsp_document_highlight
					autocmd!
					autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
					autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
					augroup END
					]], false)
				end
			end
			-- Use a loop to conveniently both setup defined servers 
			-- and map buffer local keybindings when the language server attaches
			for _, lsp in ipairs(servers) do
				nvim_lsp[lsp].setup {on_attach = on_attach}
			end
		end,
	}

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

	--[[ use {
		'oberblastmeister/neuron.nvim',
		requires = {'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim'},
		config = function()
			require'neuron'.setup{
				neuron_dir = "~/doc/notes",
				leader = "<Leader>n",
			}
		end,
	} ]]
end

local install_path = vim.fn.stdpath'data'..'/site/pack/packer/opt/packer.nvim'
local compile_path = vim.fn.stdpath('data')..'/packer_load.vim'

local first_time = false
if vim.fn.empty(vim.fn.glob(install_path)) == 1 then
	vim.fn.system('git clone --depth 1 https://github.com/wbthomason/packer.nvim.git '..install_path)
	first_time = true
end

local packer_already_run = false
function packer_run()
	if packer_already_run then return require'packer' end
	packer_already_run = true

	vim.cmd [[packadd packer.nvim]]
	local packer = require'packer'
	packer.init{compile_path = compile_path}
	packer.reset()
	use_packages(packer.use)

	return packer
end

if first_time then
	packer_run().install()
end

if vim.fn.empty(vim.fn.glob(compile_path)) == 1 then
	packer_run().compile()
end

vim.api.nvim_command('silent! source '..compile_path)

if packer_plugins == nil then
	packer_run().compile()
end
