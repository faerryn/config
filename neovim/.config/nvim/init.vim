set hidden termguicolors

let s:faevim_d = expand('$XDG_CONFIG_HOME/faevim')
let s:plugged_d = fnamemodify($MYVIMRC, ':h') . '/plugged'

execute 'augroup Personal'
autocmd!

execute 'source' s:faevim_d . '/core.vim'
call plug#begin(s:plugged_d)
execute 'source' s:faevim_d . '/list.vim'
call plug#end()
if !isdirectory(s:plugged_d) | PlugInstall | endif

for s:config in split(glob(s:faevim_d . '/configs/*.vim'), '\n')
    execute 'source' s:config
endfor

execute 'augroup END'
