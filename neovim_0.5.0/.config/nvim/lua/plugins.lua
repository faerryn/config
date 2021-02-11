function use_packages()
	use 'wbthomason/packer.nvim'

	use 'antoinemadec/FixCursorHold.nvim'

	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function() require'nvim-treesitter.configs'.setup{highlights={enable=true}} end,
	}

	use {
		'sainnhe/gruvbox-material',
		config = function()
			vim.o.termguicolors = true
			vim.g.gruvbox_material_better_performance = 1
			vim.g.gruvbox_material_palette = 'original'
			vim.g.gruvbox_material_statusline_style = 'original'
			vim.g.gruvbox_material_enable_bold = 1
			vim.g.gruvbox_material_enable_italic = 1
			vim.g.gruvbox_material_transparent_background = 1
			vim.g.gruvbox_material_diagnostic_text_highlight = 1
			vim.cmd [[colorscheme gruvbox-material]]
		end,
	}

	use {
		'hoob3rt/lualine.nvim',
		config = function() require'lualine'.status() end,
	}

	use {
		'nvim-telescope/telescope.nvim',
		requires = {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'},
		config = function()
			local actions = require('telescope.actions')
			require('telescope').setup{defaults = {mappings = {i = {["<esc>"] = actions.close}}}}
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
				vim.api.nvim_buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

				local keymap_opts = {noremap = true, silent = true}

				-- Mappings.
				vim.api.nvim_buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', keymap_opts)
				vim.api.nvim_buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', keymap_opts)

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
		config = function()
			vim.api.nvim_exec([[
			augroup neogit_keybindings
			autocmd!
			autocmd FileType NeogitStatus nnoremap <silent> <buffer> <Esc> <C-W>c
			autocmd FileType NeogitStatus execute 'lcd' system('git rev-parse --show-toplevel')
			augroup END
			]], false)
			vim.api.nvim_set_keymap('n', '<Leader>g', '<cmd>lua require"neogit".status.create"split"<CR>', {noremap = true, silent = true})
		end,
	}

	use {
		'lewis6991/gitsigns.nvim',
		requires = 'nvim-lua/plenary.nvim',
		config = function()
			require('gitsigns').setup{signs = {
				add          = {hl = 'GitGutterAdd'   , text = '+'},
				change       = {hl = 'GitGutterChange', text = '~'},
				delete       = {hl = 'GitGutterDelete', text = '_'},
				topdelete    = {hl = 'GitGutterDelete', text = '‾'},
				changedelete = {hl = 'GitGutterChange', text = '~'},
			}}
		end,
	}

	use {
		'mbbill/undotree',
		config = function()
			vim.g.undotree_WindowLayout = 4
			vim.api.nvim_exec([[
			function! g:Undotree_CustomMap() abort
				nnoremap <silent> <buffer> <Esc> <cmd>UndotreeHide<CR>
			endfunction
			]], false)
			vim.api.nvim_set_keymap('n', '<Leader>u', '<cmd>UndotreeToggle|UndotreeFocus<CR>', {noremap = true, silent = true})
		end,
	}
end

local install_path = vim.fn.stdpath'data'..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) == 1 then
	vim.fn.system('git clone --depth 1 https://github.com/wbthomason/packer.nvim.git '..install_path)
	vim.api.nvim_exec([[
	augroup personal_packer
	autocmd!
	autocmd VimEnter * PackerSync
	augroup END
	]], false)
end

require'packer'.startup{
	use_packages,
	config = {compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.vim'},
}
