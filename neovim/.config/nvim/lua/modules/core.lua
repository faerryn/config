return { setup = function()
	vim.o.hidden = true

	vim.o.clipboard = 'unnamedplus'
	vim.o.mouse = 'ar'

	vim.o.timeoutlen = 500

	vim.o.swapfile = false
	vim.o.undofile = true
	vim.bo.swapfile = false
	vim.bo.undofile = true

	vim.g.mapleader = ' '

	vim.wo.number = true
	vim.wo.relativenumber = true
	vim.wo.signcolumn = 'number'

	vim.o.spellcapcheck = ''
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

	vim.o.tabstop = 2
	vim.o.shiftwidth = 2
	vim.o.expandtab = false
	vim.bo.tabstop = 2
	vim.bo.shiftwidth = 2
	vim.bo.expandtab = false

	vim.o.list = true
	vim.o.listchars = 'eol:↲,tab:» ,trail:⋅,extends:…,precedes:…,nbsp:⎵'
	vim.wo.list = true

	vim.o.completeopt = 'menuone,noinsert,noselect'
	vim.o.confirm = true
	vim.o.foldlevelstart = 99
	vim.o.inccommand = 'nosplit'
	vim.o.iskeyword = 'a-z,A-Z,48-57,_,-'
	vim.o.lazyredraw = true
	vim.o.nrformats = 'alpha,octal,hex,bin'

	if vim.fn.executable('rg') == 1 then
		vim.o.grepprg = 'rg --hidden --vimgrep'
		vim.o.grepformat = '%f:%l:%c:%m'
	end

	local keymap_opts = { noremap = true, silent = true }

	vim.api.nvim_set_keymap('n', 's', '', keymap_opts)
	vim.api.nvim_set_keymap('v', 's', '', keymap_opts)
	vim.api.nvim_set_keymap('n', 'S', '', keymap_opts)
	vim.api.nvim_set_keymap('v', 'S', '', keymap_opts)
	vim.api.nvim_set_keymap('n', '<Leader>', '', keymap_opts)

	vim.api.nvim_exec([[
	augroup custom_core
	autocmd!
	autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup = "Search", timeout = 300 }
	autocmd BufWritePre * call mkdir(expand('%:p:h'), 'p')
	augroup END
	]], false)

	-- Disable netrw
	vim.g.loaded_netrw       = 1
	vim.g.loaded_netrwPlugin = 1

	-- FixCursorHold.nvim
	vim.api.nvim_command'packadd FixCursorHold.nvim'
	vim.g.cursorhold_updatetime = 1000

	-- vim-repeat
	vim.api.nvim_command'packadd vim-repeat'

	-- readline.vim
	vim.api.nvim_command'packadd readline.vim'

	-- vim-dirvish
	vim.api.nvim_command'packadd vim-dirvish'
end }
