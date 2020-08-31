" core
silent! helptags ALL

" gruvbox
colorscheme gruvbox

" vim-startify
let g:startify_custom_header = startify#pad(split(system('figlet -f big FAEVIM'), '\n'))

" nvim-colorizer.lua
lua require'colorizer'.setup()
