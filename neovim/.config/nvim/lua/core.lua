return { setup = function()
	vim.o.hidden = true

	vim.o.clipboard = 'unnamedplus'
	vim.o.mouse = 'ar'

	vim.o.timeoutlen = 300

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

	vim.o.confirm = true
	vim.o.foldlevelstart = 99
	vim.o.inccommand = 'nosplit'
	vim.o.iskeyword = 'a-z,A-Z,48-57,_,-'
	vim.o.lazyredraw = true
	vim.o.nrformats = 'alpha,octal,hex,bin'

	vim.o.termguicolors = true

	if vim.fn.executable('rg') == 1 then
		vim.o.grepprg = 'rg --hidden --vimgrep'
		vim.o.grepformat = '%f:%l:%c:%m'
	end

	if vim.fn.executable('/bin/sh') == 1 then
		vim.o.shell = '/bin/sh'
	end

	local keymap_opts = { noremap = true, silent = true }

	vim.api.nvim_set_keymap('n', 'Y', 'y$', keymap_opts)
	vim.api.nvim_set_keymap('n', ']a', '<Cmd>next<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', '[a', '<Cmd>previous<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', ']A', '<Cmd>last<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', '[A', '<Cmd>first<CR>', keymap_opts)

	vim.api.nvim_set_keymap('n', ']b', '<Cmd>bnext<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', '[b', '<Cmd>bprevious<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', ']B', '<Cmd>blast<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', '[B', '<Cmd>bfirst<CR>', keymap_opts)

	vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>lopen<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', '<Leader>q', '<Cmd>copen<CR>', keymap_opts)

	vim.api.nvim_set_keymap('n', ']q', '<Cmd>cnext<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', '[q', '<Cmd>cprevious<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', ']Q', '<Cmd>clast<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', '[Q', '<Cmd>cfirst<CR>', keymap_opts)

	vim.api.nvim_set_keymap('n', ']l', '<Cmd>lnext<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', '[l', '<Cmd>lprevious<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', ']L', '<Cmd>llast<CR>', keymap_opts)
	vim.api.nvim_set_keymap('n', '[L', '<Cmd>lfirst<CR>', keymap_opts)

	vim.api.nvim_set_keymap('n', 's', '', keymap_opts)
	vim.api.nvim_set_keymap('v', 's', '', keymap_opts)
	vim.api.nvim_set_keymap('n', 'S', '', keymap_opts)
	vim.api.nvim_set_keymap('v', 'S', '', keymap_opts)
	vim.api.nvim_set_keymap('n', '<Leader>', '', keymap_opts)

	vim.api.nvim_exec([[
	augroup personal
	autocmd!
	autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup = "Search", timeout = 300 }
	autocmd BufWritePre * call mkdir(expand('%:p:h'), 'p')
	augroup END
	]], false)

	vim.g.loaded_netrw       = 1
	vim.g.loaded_netrwPlugin = 1
end }
