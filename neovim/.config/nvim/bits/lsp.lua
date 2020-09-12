local nvim_lsp = require'nvim_lsp'
nvim_lsp.clangd.setup{}
nvim_lsp.gopls.setup{}
nvim_lsp.rls.setup{}
-- if not nvim_lsp.zls then
	-- nvim_lsp.configs.zls = {
		-- default_config = {
			-- cmd = {'zls'};
			-- filetypes = {'zig'};
			-- root_dir = nvim_lsp.util.root_pattern('build.zig');
			-- settings = {};
		-- };
	-- }
-- end
-- nvim_lsp.zls.setup{}
