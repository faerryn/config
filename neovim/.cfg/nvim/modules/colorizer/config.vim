packadd nvim-colorizer.lua
autocmd Personal BufEnter * lua require'colorizer'.attach_to_buffer(0)
