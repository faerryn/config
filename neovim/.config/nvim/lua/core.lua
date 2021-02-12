return {setup = function()
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

	vim.o.exrc = true

	if vim.fn.executable('rg') == 1 then
		vim.o.grepprg = 'rg --hidden --vimgrep'
		vim.o.grepformat = '%f:%l:%c:%m'
	end

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

	vim.api.nvim_exec([[
	augroup personal
	autocmd!
	autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup = "Search", timeout = 300}
	autocmd BufWritePre * call mkdir(expand('%:p:h'), 'p')
	augroup END
	]], false)

	vim.g.netrw_dirhistmax = 0
end}
