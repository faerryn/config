local modules = {
	require'config.modules.vanilla',
	require'config.modules.filetypes',

	require'config.modules.colorscheme',
	require'config.modules.statusline',
	require'config.modules.colors',

	require'config.modules.treesitter',
	require'config.modules.lsp',

	require'config.modules.align',
	require'config.modules.comments',
	require'config.modules.surround',

	require'config.modules.git',
	require'config.modules.telescope',
	require'config.modules.undotree',
	require'config.modules.startuptime',
}

local function config()
	for _, module in ipairs(modules) do
		module.config()
	end
end

local function packages()
	vim.api.nvim_command'packadd paq-nvim'
	local paq = require'paq-nvim'
	paq.paq{ 'savq/paq-nvim', opt = true }
	for _, module in ipairs(modules) do
		module.packages(paq.paq)
	end
	paq.clean()
	paq.install()
	config()
end

local function setup()
	require'config.core'.setup()
	local install_path = vim.fn.stdpath'data'..'/site/pack/paqs/opt/paq-nvim'
	if vim.fn.empty(vim.fn.glob(install_path)) == 1 then
		vim.fn.system('git clone --depth 1 https://github.com/savq/paq-nvim.git '..install_path)
		packages()
	end
	vim.api.nvim_command[[command! Reload lua require'config'.packages()]]
	config()
end

return {
	setup = setup,
	packages = packages,
	config = config,
}
