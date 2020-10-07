vim.o.termguicolors = true
vim.cmd'colorscheme gruvbox'
vim.o.background    = 'dark'
vim.cmd'doautocmd ColorScheme'

local prose_mode = false
function fey.user.toggle_prose()
	prose_mode = not prose_mode
	if prose_mode then
		vim.cmd'noremap j gj'
		vim.cmd'noremap k gk'
		vim.cmd'noremap 0 g0'
		vim.cmd'noremap ^ g^'
		vim.cmd'noremap $ g$'

		print'Prose mode ON'
	else
		vim.cmd'unmap j'
		vim.cmd'unmap k'
		vim.cmd'unmap 0'
		vim.cmd'unmap ^'
		vim.cmd'unmap $'

		print'Prose mode OFF'
	end
end
vim.cmd'command! Prose lua fey.user.toggle_prose()'
