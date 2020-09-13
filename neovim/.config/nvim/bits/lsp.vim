function! s:setup_lsp() abort
	nnoremap <silent> <buffer> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
	nnoremap <silent> <buffer> <C-]> <cmd>lua vim.lsp.buf.definition()<CR>
	nnoremap <silent> <buffer> K     <cmd>lua vim.lsp.buf.hover()<CR>
	nnoremap <silent> <buffer> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
	nnoremap <silent> <buffer> <C-K> <cmd>lua vim.lsp.buf.signature_help()<CR>
	nnoremap <silent> <buffer> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
	nnoremap <silent> <buffer> gr    <cmd>lua vim.lsp.buf.references()<CR>
	nnoremap <silent> <buffer> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
	nnoremap <silent> <buffer> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
	setlocal omnifunc=v:lua.vim.lsp.omnifunc
	setlocal formatexpr=v:lua.vim.lsp.buf.formatting
	autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
endfunction
autocmd FileType zig call s:setup_lsp()
