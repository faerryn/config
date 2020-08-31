let g:plug_window='split new'
let g:plug_pwindow='split'

autocmd FileType vim-plug nmap <Esc> q

call plug#begin(g:personal_vim_d . '/plugged')

Plug 'aymericbeaumet/vim-symlink'
Plug 'chaoren/vim-wordmotion'
Plug 'machakann/vim-sandwich'
Plug 'machakann/vim-swap'
Plug 'mbbill/undotree'
Plug 'moll/vim-bbye'
Plug 'pbrisbin/vim-mkdir'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'ziglang/zig.vim'

Plug 'gruvbox-community/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'mhinz/vim-signify'
Plug 'norcalli/nvim-colorizer.lua'

call plug#end()
