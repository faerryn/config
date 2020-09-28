fey_core_set_colorscheme('gruvbox', 'dark')

local prose_mode = false
function fey_user_toggle_prose()
	prose_mode = not prose_mode
	if prose_mode then
		vim.cmd'noremap j gj'
		vim.cmd'noremap k gk'
		vim.cmd'noremap 0 g0'
		vim.cmd'noremap ^ g^'
		vim.cmd'noremap $ g$'
		vim.cmd'noremap <End> g<End>'

		print'Prose mode ON'
	else
		vim.cmd'unmap j'
		vim.cmd'unmap k'
		vim.cmd'unmap 0'
		vim.cmd'unmap ^'
		vim.cmd'unmap $'
		vim.cmd'unmap <End>'

		print'Prose mode OFF'
	end
end
vim.cmd'command! Prose lua fey_user_toggle_prose()'
