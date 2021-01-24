packadd vim-fugitive
nnoremap <silent> <Leader>g <cmd>belowright G<CR>
autocmd Personal FileType fugitive nmap <silent> <buffer> <Esc> gq

autocmd! fugitive BufReadPost * call FugitiveDetect(resolve(expand('<amatch>:p')))
