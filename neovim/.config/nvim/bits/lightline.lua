vim.cmd"autocmd VimEnter,ColorScheme * lua vim.g.lightline = { tabline = { right = {} }, colorscheme = vim.g.colors_name or 'default' }; vim.fn['lightline#enable']()"
