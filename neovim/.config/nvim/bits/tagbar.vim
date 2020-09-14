nnoremap <silent> <Leader>t <cmd>TagbarOpen fjc<CR>
autocmd FileType tagbar nnoremap <silent> <buffer> <Esc> <cmd>TagbarClose<CR>
let g:tagbar_width = 35
let g:tagbar_type_zig = {
			\ 'ctagstype': 'zig',
			\ 'kinds' : [ 'f:functions', 's:structs', 'e:enums', 'u:unions', 'E:errors' ]
			\ }
