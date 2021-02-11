vim.o.hidden = true

vim.o.clipboard = 'unnamedplus'
vim.o.mouse = 'ar'

vim.o.timeoutlen = 500
vim.o.updatetime = 500

vim.o.swapfile = false
vim.o.undofile = true

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

vim.o.linebreak = true
vim.o.wrap = true

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

local opts = { noremap = true, silent = true }

vim.fn.nvim_set_keymap('n', 's', '', opts)
vim.fn.nvim_set_keymap('v', 's', '', opts)
vim.fn.nvim_set_keymap('n', 'S', '', opts)
vim.fn.nvim_set_keymap('v', 'S', '', opts)
vim.fn.nvim_set_keymap('n', '<Leader>', '', opts)
vim.fn.nvim_set_keymap('n', 'Y', 'y$', opts)

local packer_install_dir = vim.fn.stdpath'data'..'/site/pack/packer/opt/packer.nvim'
if vim.fn.isdirectory(packer_install_dir) == 0 then
	vim.fn.system('git clone --depth 1 https://github.com/wbthomason/packer.nvim.git '..packer_install_dir)
end

vim.cmd [[packadd packer.nvim]]

require'packer'.startup(function()
end)
