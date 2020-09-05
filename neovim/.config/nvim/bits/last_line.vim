autocmd BufReadPost * if line("'\"") > 0 && line("'\"") < line('$') | execute "normal! g'\"" | endif
