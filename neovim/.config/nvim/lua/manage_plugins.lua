return{setup = function()
	local install_path = vim.fn.stdpath'data'..'/site/pack/packer/opt/packer.nvim'
	local compile_path = vim.fn.stdpath('data')..'/packer_load.vim'

	local packer_run_already = false
	local function packer_run()
		if packer_run_already then return end
		packer_run_already = true
		vim.cmd [[packadd packer.nvim]]
		require'use_plugins'.setup()
	end

	if vim.fn.empty(vim.fn.glob(install_path)) == 1 then
		vim.fn.system('git clone --depth 1 https://github.com/wbthomason/packer.nvim.git '..install_path)
		packer_run()
		require'packer'.install()
	end

	vim.api.nvim_command('silent! source '..compile_path)

	if packer_plugins == nil then
		packer_run()
		require'packer'.compile()
	end
end}
