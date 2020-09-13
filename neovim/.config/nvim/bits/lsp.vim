function! s:setup_lsp() abort
	if exists('b:Personal_LSP') | return | endif
	let b:Personal_LSP=1
	nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
	nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
	nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
	nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
	nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
	nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
	nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
	nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
	nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
	setlocal omnifunc=v:lua.vim.lsp.omnifunc
	setlocal formatexpr=v:lua.vim.lsp.buf.formatting
	autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
endfunction
autocmd FileType c,cpp,rust,zig call s:setup_lsp()
