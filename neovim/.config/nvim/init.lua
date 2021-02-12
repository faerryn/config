require'core'.setup()

local plugins = require'plugins'

if vim.fn.empty(vim.fn.glob(plugins.install_path)) == 1 then
	vim.fn.system('git clone --depth 1 https://github.com/wbthomason/packer.nvim.git '..plugins.install_path)
end

vim.api.nvim_command('silent! source '..plugins.compile_path)

if packer_plugins == nil then
	vim.cmd[[packadd packer.nvim]]
	plugins.setup()
	local packer = require'packer'
	packer.install()
	packer.compile()
end
