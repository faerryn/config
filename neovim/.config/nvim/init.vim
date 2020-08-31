execute 'augroup Personal'
autocmd!

let g:personal_vim_d = fnamemodify($MYVIMRC, ':h')
execute 'source ' . g:personal_vim_d . '/pre.vim'
execute 'source ' . g:personal_vim_d . '/plugins.vim'
if !isdirectory(g:personal_vim_d . '/plugged/') | PlugInstall | endif
execute 'source ' . g:personal_vim_d . '/post.vim'

execute 'augroup END'
