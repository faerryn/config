local list_f    = vim.fn.stdpath('config') .. '/list.vim'
local bits_d    = vim.fn.stdpath('config') .. '/bits'
local plug_vim  = vim.fn.stdpath('data')   .. '/site/autoload/plug.vim'
local plugged_d = vim.fn.stdpath('data')   .. '/plugged'
local plug_doc  = vim.fn.stdpath('data')   .. '/site/doc/plug.txt'

local function try_source (source_file)
	local file_extension = vim.fn.fnamemodify(source_file, ':e')
	if file_extension == 'vim' then
		pcall(vim.cmd, 'source ' .. source_file)
	elseif file_extension == 'lua' then
		pcall(vim.cmd, 'luafile ' .. source_file)
	end
end

function enhanced_source (source_file)
	if io.open(source_file) == nil then return end
	source_file = vim.fn.resolve(source_file)
	vim.cmd('augroup Personal' .. source_file:gsub('[/|.]', '_'))
	vim.cmd('autocmd!')
	try_source(source_file)
	vim.cmd('autocmd BufWritePost ' .. source_file .. ' lua enhanced_source"' .. source_file .. '"')
	vim.cmd('augroup END')
end

vim.cmd('augroup PersonalInit')
vim.cmd('autocmd!')
vim.cmd('augroup END')

-- CORE
enhanced_source(vim.fn.stdpath('config') .. '/core.vim')
enhanced_source(vim.fn.stdpath('config') .. '/core.lua')

-- VIM-PLUG
vim.g.plug_window = 'new'
vim.g.plug_pwindow = 'new'
vim.cmd('autocmd PersonalInit FileType vim-plug nnoremap <silent> <buffer> <Esc> <C-W>c')

local plug_vim = vim.fn.stdpath('data') .. '/site/autoload/plug.vim'
local plug_doc = vim.fn.stdpath('data') .. '/site/doc/plug.txt'
if io.open(plug_vim) == nil then
	vim.cmd('silent !curl -fLo "' .. plug_vim .. '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
	vim.cmd('silent !curl -fLo "' .. plug_doc .. '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/doc/plug.txt')
	vim.cmd('helptag ' .. vim.fn.fnamemodify(plug_doc, ':p:h'))
end

-- PLUG_LIST
function load_list ()
	vim.fn['plug#begin'](plugged_d)
	try_source(list_f)
	vim.fn['plug#end']()
end
load_list()
vim.cmd('autocmd PersonalInit BufWritePost ' .. vim.fn.resolve(list_f) .. ' lua load_list()')

if not vim.fn.isdirectory(plugged_d) then vim.cmd('PlugInstall') end

-- BITS
for config_f in vim.fn.glob(bits_d .. '/*.{vim,lua}'):gmatch('[^\n]+') do
	enhanced_source(config_f)
end
