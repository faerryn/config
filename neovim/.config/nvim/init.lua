faevim_d = vim.fn.expand("$XDG_CONFIG_HOME/faevim")
vim.cmd("source " .. faevim_d .. "/core.vim")

nvim_d = vim.fn.expand("$XDG_CONFIG_HOME/nvim")
local faevim_dein_d = nvim_d .. "/dein.vim"
local faevim_dein_cache_d = nvim_d .. "/dein_cache"

vim.o.runtimepath = faevim_dein_d .. "," .. vim.o.runtimepath

if vim.fn["dein#load_state"](faevim_dein_cache_d) == 1 then
    vim.fn["dein#begin"](faevim_dein_cache_d)
    vim.fn["dein#add"](faevim_dein_d)
    for _, plugin in pairs(dofile(faevim_d .. "/list.lua")) do
	vim.fn["dein#add"](plugin)
    end
    vim.fn["dein#end"]()
    vim.fn["dein#save_state"]()
end

if vim.fn.isdirectory(faevim_dein_cache_d .. "/repos") == 0 then
    vim.fn["dein#install"]()
end

for config in string.gmatch(vim.fn.glob(faevim_d .. "/configs/*.vim"), "[^\n]+") do
    vim.cmd("source " .. config)
end

for config in string.gmatch(vim.fn.glob(faevim_d .. "/configs/*.lua"), "[^\n]+") do
    dofile(config)
end
