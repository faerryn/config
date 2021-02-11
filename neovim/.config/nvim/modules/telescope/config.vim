if !has('nvim-0.5.0')
	finish
endif

packadd popup.nvim
packadd plenary.nvim
packadd telescope.nvim

execute 'luafile' expand('<sfile>:h').'/config.lua'
