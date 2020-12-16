local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'

lspconfig.clangd.setup{ cmd = { "clangd", "--background-index", "--clang-tidy" } }
lspconfig.rust_analyzer.setup{}
configs.zls = {
	default_config = {
		cmd = { "zls" };
		filetype = { "zig" };
		root_dir = lspconfig.util.root_pattern("build.zig");
		settings = {};
	};
}
lspconfig.zls.setup{}
