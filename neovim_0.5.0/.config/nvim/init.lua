vim.o.hidden = true

vim.o.clipboard = 'unnamedplus'
vim.o.mouse = 'ar'

vim.o.timeoutlen = 500
vim.o.updatetime = 500

vim.bo.swapfile = false
vim.bo.undofile = true

vim.g.mapleader = ' '

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'number'

vim.bo.spellcapcheck = ''

vim.o.laststatus = 2
vim.o.showtabline = 2
vim.o.showmode = false
vim.o.showcmd = false

vim.o.equalalways = false
vim.o.splitbelow = true
vim.o.splitright = true

vim.wo.linebreak = true
vim.wo.wrap = false

vim.o.confirm = true
vim.o.foldlevelstart = 99
vim.o.inccommand = 'nosplit'
vim.o.iskeyword = 'a-z,A-Z,48-57,_,-'
vim.o.lazyredraw = true
vim.o.nrformats = 'alpha,octal,hex,bin'

vim.o.exrc = true

if vim.fn.executable('rg') == 1 then
	vim.o.grepprg = 'rg --hidden --ignore-file "'..vim.fn.getenv'XDG_CONFIG_HOME'..'"/git/ignore --vimgrep'
	vim.o.grepformat = '%f:%l:%c:%m'
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local keymap_opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', 'Y', 'y$', keymap_opts)
vim.api.nvim_set_keymap('n', ']a', '<cmd>next<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '[a', '<cmd>previous<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', ']A', '<cmd>last<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '[A', '<cmd>first<CR>', keymap_opts)

vim.api.nvim_set_keymap('n', ']b', '<cmd>bnext<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '[b', '<cmd>bprevious<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', ']B', '<cmd>blast<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '[B', '<cmd>bfirst<CR>', keymap_opts)

vim.api.nvim_set_keymap('n', '<Leader>l', '<cmd>lopen<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '<Leader>q', '<cmd>copen<CR>', keymap_opts)

vim.api.nvim_set_keymap('n', ']q', '<cmd>cnext<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '[q', '<cmd>cprevious<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', ']Q', '<cmd>clast<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '[Q', '<cmd>cfirst<CR>', keymap_opts)

vim.api.nvim_set_keymap('n', ']l', '<cmd>lnext<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '[l', '<cmd>lprevious<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', ']L', '<cmd>llast<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '[L', '<cmd>lfirst<CR>', keymap_opts)

vim.api.nvim_set_keymap('n', 's', '', keymap_opts)
vim.api.nvim_set_keymap('v', 's', '', keymap_opts)
vim.api.nvim_set_keymap('n', 'S', '', keymap_opts)
vim.api.nvim_set_keymap('v', 'S', '', keymap_opts)
vim.api.nvim_set_keymap('n', '<Leader>', '', keymap_opts)

local packer_install_dir = vim.fn.stdpath'data'..'/site/pack/packer/opt/packer.nvim'
if vim.fn.isdirectory(packer_install_dir) == 0 then
	vim.fn.system('git clone --depth 1 https://github.com/wbthomason/packer.nvim.git '..packer_install_dir)
end

vim.cmd [[packadd packer.nvim]]

require'packer'.startup{function()
	use {'wbthomason/packer.nvim', opt = true}

	use 'antoinemadec/FixCursorHold.nvim'

	use 'tpope/vim-abolish'

	use {
		'morhetz/gruvbox',
		config = function()
			vim.o.termguicolors = true
			vim.g.gruvbox_bold = 1
			vim.g.gruvbox_italic = 1
			vim.g.gruvbox_underline = 1
			vim.g.gruvbox_undercurl = 1
			vim.g.gruvbox_hls_cursor = 'orange'
			vim.g.gruvbox_guisp_fallback = 'fg'
			vim.g.gruvbox_invert_selection = 0
			vim.g.gruvbox_invert_signs = 0
			vim.g.gruvbox_invert_indent_guides = 0
			vim.g.gruvbox_invert_tabline = 0
			vim.g.gruvbox_italicize_comments = 1
			vim.g.gruvbox_italicize_strings = 1
			vim.g.gruvbox_improved_strings = 1
			vim.g.gruvbox_improved_warnings = 1
			vim.cmd [[colorscheme gruvbox]]
		end,
	}

	use {
		'hoob3rt/lualine.nvim',
		config = function()
			require'lualine'.status()
		end,
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

			local servers = { 'clangd', 'rust_analyzer', 'zls' }
			nvim_lsp.clangd.cmd = { 'clangd', '--background-index', '--clang-tidy' }
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

				local keymap_opts = { noremap = true, silent = true }

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
					vim.cmd([[
					augroup lsp_document_autoformat
					autocmd!
					autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
					augroup END
					]], false)
				end

				-- Set autocommands conditional on server_capabilities
				if client.resolved_capabilities.document_highlight then
					vim.cmd([[
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
				nvim_lsp[lsp].setup { on_attach = on_attach }
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
		config = function() vim.api.nvim_set_keymap('n', '<Leader>g', '<cmd>lua require"neogit".status.create"split"<CR>', { noremap = true, silent = true }) end,
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
end}
