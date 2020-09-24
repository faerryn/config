local list_f    = vim.fn.stdpath'config' .. '/list.vim'
local bits_d    = vim.fn.stdpath'config' .. '/bits'
local plug_vim  = vim.fn.stdpath'data'   .. '/site/autoload/plug.vim'
local plugged_d = vim.fn.stdpath'data'   .. '/plugged'
local plug_doc  = vim.fn.stdpath'data'   .. '/site/doc/plug.txt'

local sourcers = {
	vim = function (file) vim.cmd('source ' .. file) end,
	lua = dofile,
}
local function try_source (file)
	local status, err = pcall(sourcers[vim.fn.fnamemodify(file, ':e')], file)
	if not status then
		print('Error in ' .. file .. ':\n' .. err)
	end
end

local real_config = vim.fn.resolve(vim.fn.stdpath'config'):gsub('[~|/|.]', '_')
function personal_enhanced_source (file, ...)
	if io.open(file) == nil then return end
	local arg = {...}
	if arg[1] then arg[1]() end
	file = vim.fn.resolve(file)
	vim.cmd('augroup ' .. file:gsub('[~|/|.]', '_'):gsub('^' .. real_config, ''))
	vim.cmd'autocmd!'
	try_source(file)
	vim.cmd('autocmd BufWritePost ' .. file .. ' lua personal_enhanced_source"' .. file .. '"')
	vim.cmd'augroup END'
	if arg[2] then arg[2]() end
end

-- CORE
personal_enhanced_source(vim.fn.stdpath'config' .. '/core.vim')
personal_enhanced_source(vim.fn.stdpath'config' .. '/core.lua')

-- VIM-PLUG
vim.g.plug_window  = 'new'
vim.g.plug_pwindow = 'new'

vim.cmd'augroup _init_lua'
vim.cmd'autocmd!'
vim.cmd'autocmd FileType vim-plug nnoremap <silent> <buffer> <Esc> <C-W>c'
vim.cmd'augroup END'

local plug_vim = vim.fn.stdpath'data' .. '/site/autoload/plug.vim'
local plug_doc = vim.fn.stdpath'data' .. '/site/doc/plug.txt'
if io.open(plug_vim) == nil then
	vim.cmd('silent !curl -fLo "' .. plug_vim .. '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
	vim.cmd('silent !curl -fLo "' .. plug_doc .. '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/doc/plug.txt')
	vim.cmd('helptag ' .. vim.fn.fnamemodify(plug_doc, ':p:h'))
end

-- PLUG_LIST
personal_enhanced_source(list_f,
function () vim.fn['plug#begin'](plugged_d) end,
function ()
	vim.fn['plug#end']()
	if not vim.fn.isdirectory(plugged_d) then
		vim.cmd'PlugInstall'
	end
end)

-- BITS
for config_f in vim.fn.glob(bits_d .. '/*.{vim,lua}'):gmatch'[^\n]+' do
	personal_enhanced_source(config_f)
end
