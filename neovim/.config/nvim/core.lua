vim.o.clipboard       = 'unnamedplus'
vim.o.confirm         = true
vim.o.foldlevelstart  = 99
vim.o.hidden          = true
vim.o.inccommand      = 'nosplit'
vim.o.iskeyword       = 'a-z,A-Z,48-57,_,-'
vim.bo.iskeyword      = 'a-z,A-Z,48-57,_,-'
vim.o.lazyredraw      = true
vim.g.mapleader       = ' '
vim.o.mouse           = 'ar'
vim.o.nrformats       = 'alpha,octal,hex,bin'
vim.bo.nrformats      = 'alpha,octal,hex,bin'
vim.o.omnifunc        = 'syntaxcomplete#Complete'
vim.bo.omnifunc       = 'syntaxcomplete#Complete'
vim.o.spell           = true
vim.wo.spell          = true
vim.o.spellcapcheck   = ''
vim.bo.spellcapcheck  = ''
vim.o.undofile        = true
vim.bo.undofile       = true

vim.o.timeoutlen      = 500
vim.o.updatetime      = 500

vim.o.shadafile       = vim.fn.stdpath'cache' .. '/shada/main.shada'
vim.o.directory       = vim.fn.stdpath'cache' .. '/swap'
vim.o.undodir         = vim.fn.stdpath'cache' .. '/undo'

vim.o.equalalways     = false
vim.o.laststatus      = 2
vim.wo.linebreak      = true
vim.wo.number         = true
vim.wo.relativenumber = true
vim.o.showcmd         = false
vim.o.showmode        = false
vim.o.showtabline     = 2
vim.wo.signcolumn     = 'number'
vim.o.splitbelow      = true
vim.o.splitright      = true
vim.wo.wrap           = true

vim.o.background      = 'dark'
vim.o.termguicolors   = true
vim.cmd'doautocmd ColorScheme'
