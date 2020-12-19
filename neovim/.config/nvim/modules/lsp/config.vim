if has('nvim-0.5.0')
	packadd nvim-lspconfig
	execute 'luafile' expand('<sfile>:h').'/config.lua'
endif
