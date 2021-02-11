require'core'

local install_path = vim.fn.stdpath'data'..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) == 1 then
	vim.fn.system('git clone --depth 1 https://github.com/wbthomason/packer.nvim.git '..install_path)
	vim.api.nvim_exec([[
	augroup personal_packer
	autocmd!
	autocmd VimEnter * PackerSync
	augroup END
	]], false)
end

require'packer'.startup{
	require'plugins',
	config = {compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.vim'},
}
