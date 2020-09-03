autocmd BufEnter * if !empty(@%) && empty(&buftype) | silent! lcd %:p:h | endif
autocmd BufWritePost * if !empty(@%) && empty(&buftype) | silent! lcd %:p:h | endif
