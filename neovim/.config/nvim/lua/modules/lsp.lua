return { setup = function()
	vim.api.nvim_command'packadd nvim-lspconfig'
	vim.api.nvim_command'packadd completion-nvim'

	local lspconfig = require'lspconfig'

	local servers = { 'clangd', 'rust_analyzer', 'zls' }

	local on_attach = function(client, bufnr)
		vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
		local keymap_opts = { noremap = true, silent = true }
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', keymap_opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>',  keymap_opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',  '<Cmd>lua vim.lsp.buf.hover()<CR>',       keymap_opts)

		vim.api.nvim_command'command! -buffer Format lua vim.lsp.buf.formatting_sync()'
		vim.api.nvim_command'command! -buffer Rename lua vim.lsp.buf.rename()'

		require'completion'.on_attach(client, bufnr)
	end


	for _, server in ipairs(servers) do
		lspconfig[server].setup{ on_attach = on_attach }
	end
end }
