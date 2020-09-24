vim.g.mapleader      = ' '
vim.o.clipboard      = 'unnamedplus'
vim.o.confirm        = true
vim.o.foldlevelstart = 99
vim.o.hidden         = true
vim.o.inccommand     = 'nosplit'
vim.o.lazyredraw     = true
vim.o.mouse          = 'ar'
vim.o.timeoutlen     = 500
vim.o.updatetime     = 500

vim.o.shadafile      = vim.fn.stdpath'cache' .. '/shada/main.shada'
vim.o.directory      = vim.fn.stdpath'cache' .. '/swap'
vim.o.undodir        = vim.fn.stdpath'cache' .. '/undo'

vim.o.laststatus     = 2
vim.o.showtabline    = 2
vim.o.equalalways    = false
vim.o.showmode       = false
vim.o.showcmd        = false
vim.o.splitbelow     = true
vim.o.splitright     = true

vim.o.background     = 'dark'
vim.o.termguicolors  = true
vim.cmd'doautocmd ColorScheme'
