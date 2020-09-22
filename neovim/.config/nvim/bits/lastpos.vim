autocmd BufReadPost * lua pcall(vim.api.nvim_win_set_cursor, 0, vim.api.nvim_buf_get_mark(0, '"'))
