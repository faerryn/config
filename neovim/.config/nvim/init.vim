execute 'augroup Personal'
autocmd!

let g:personal_vim_d = fnamemodify($MYVIMRC, ':h')
execute 'source ' . g:personal_vim_d . '/core.vim'
execute 'source ' . g:personal_vim_d . '/pre.vim'
call plug#begin(g:personal_vim_d . '/plugged')
execute 'source ' . g:personal_vim_d . '/plugins.vim'
call plug#end()
if !isdirectory(g:personal_vim_d . '/plugged/') | PlugInstall | endif
execute 'source ' . g:personal_vim_d . '/post.vim'

execute 'augroup END'
