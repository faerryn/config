set cursorline cursorcolumn colorcolumn=80
set inccommand=nosplit
set lazyredraw
set noequalalways
set noruler
set noshowmode
set number relativenumber signcolumn=number
set showtabline=0
set splitbelow splitright
set termguicolors
set wrap linebreak

let g:gruvbox_bold=1
let g:gruvbox_italic=1
let g:gruvbox_underline=1
let g:gruvbox_undercurl=1
colorscheme gruvbox

let g:lightline={'colorscheme': 'gruvbox'}
call lightline#enable()
