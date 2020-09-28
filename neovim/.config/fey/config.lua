vim.cmd"autocmd fey_user VimEnter * lua fey_core_set_colorscheme('gruvbox', 'dark')"

local prose_mode = false
function fey_user_toggle_prose()
	prose_mode = not prose_mode
	if prose_mode then
		vim.cmd'nnoremap j gj'
		vim.cmd'nnoremap k gk'
		vim.cmd'nnoremap 0 g0'
		vim.cmd'nnoremap ^ g^'
		vim.cmd'nnoremap $ g$'
		vim.cmd'nnoremap <End> g<End>'

		vim.cmd'vnoremap j gj'
		vim.cmd'vnoremap k gk'
		vim.cmd'vnoremap 0 g0'
		vim.cmd'vnoremap ^ g^'
		vim.cmd'vnoremap $ g$'
		vim.cmd'vnoremap <End> g<End>'

		vim.cmd'onoremap j gj'
		vim.cmd'onoremap k gk'
		vim.cmd'onoremap 0 g0'
		vim.cmd'onoremap ^ g^'
		vim.cmd'onoremap $ g$'
		vim.cmd'onoremap <End> g<End>'

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
