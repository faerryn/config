local nvim_lsp = require'nvim_lsp'
local configs = require'nvim_lsp/configs'
local util = require'nvim_lsp/util'

if not configs.zls then
	configs.zls = {
		default_config = {
			cmd = {'zls'};
			filetypes = {'zig'};
			root_dir = util.root_pattern('build.zig', '.git');
		};
		docs = {
			description = [[ ]];
			default_config = {
				root_dir = [[root_pattern("build.zig", ".git")]];
			};
		};
	}
end

nvim_lsp.zls.setup{}
