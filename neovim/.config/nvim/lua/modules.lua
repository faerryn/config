local modules = {
	'core',
	'vanilla',
	'filetypes',

	'colorscheme',
	'statusline',
	'colorizer',

	-- 'treesitter',
	-- 'lsp',

	'align',
	'comments',
	'surround',

	'git',
	'telescope',
	'undotree',
	'startuptime',
}

local function setup()
	for _, name in ipairs(modules) do
		local module = require('modules.'..name)
		local status, err = pcall(module.setup)
		if not status then
			print(string.format("error in module %s:\n%s", name, err))
		end
	end
end

return { setup = setup }
