local servers = { 'clangd', 'rust_analyzer', 'zls' }

local on_attach = function(client, bufnr)
	local keymap_opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', keymap_opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>',  keymap_opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',  '<Cmd>lua vim.lsp.buf.hover()<CR>',       keymap_opts)

	vim.api.nvim_command'command! -buffer          CodeAction lua vim.lsp.buf.code_action()'
	vim.api.nvim_command'command! -buffer          Format     lua vim.lsp.buf.formatting_sync()'
	vim.api.nvim_command'command! -buffer -nargs=? Rename     lua vim.lsp.buf.rename("<args>")'

	require'completion'.on_attach()
end

local function get_lua_runtime()
	local result = {};
	for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
		local lua_path = path .. '/lua/';
		if vim.fn.isdirectory(lua_path) then
			result[lua_path] = true
		end
	end

	-- This loads the `lua` files from nvim into the runtime.
	result[vim.fn.expand'$VIMRUNTIME/lua'] = true

	return result;
end

return { setup = function()
	vim.api.nvim_command'packadd nvim-lspconfig'
	vim.api.nvim_command'packadd completion-nvim'

	for _, server in ipairs(servers) do
		require'lspconfig'[server].setup{ on_attach = on_attach }
	end

	require'lspconfig'.sumneko_lua.setup{
		cmd = { 'lua-language-server' },

		-- Lua LSP configuration
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
					path = vim.split(package.path, ';'),
				},

				completion = { keywordSnippet = "Disable" },

				diagnostics = {
					enable = true,
					disable =  { "trailing-space" },
					globals = { "vim" },
				},

				workspace = {
					library = get_lua_runtime(),
					maxPreload = 1000,
					preloadFileSize = 1000,
				},
			}
		},

		on_attach = on_attach,

	}

end }
