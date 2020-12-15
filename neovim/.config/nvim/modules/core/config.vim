packadd FixCursorHold.nvim

packadd vim-symlink
packadd vim-bbye
packadd vim-mkdir

packadd vim-repeat
packadd vim-visualrepeat

packadd vim-wordmotion

packadd readline.vim
packadd vim-qf

autocmd Personal FileType minpacprgs,qf nnoremap <silent> <buffer> <Esc> <C-W>c
autocmd Personal BufReadPost * call cursor(line("'\""), col("'\""))
