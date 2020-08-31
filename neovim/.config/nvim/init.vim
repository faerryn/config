execute 'augroup Personal'
autocmd!

let g:personal_vim_d = expand('<sfile>:h')
let g:personal_faevim_d = expand('$XDG_CONFIG_HOME/faevim')
execute 'source' g:personal_faevim_d . '/core.vim'

let g:personal_plugged = g:personal_vim_d . '/plugged'
call plug#begin(g:personal_plugged)
execute 'source' g:personal_faevim_d . '/list.vim'
call plug#end()
execute 'source' g:personal_faevim_d . '/packages/vim-plug.vim'
if !isdirectory(g:personal_plugged) | PlugInstall | endif
for s:plugin in split(&runtimepath, ',')
    let s:plugin = expand(g:personal_faevim_d . '/packages/' . fnamemodify(s:plugin, ':t:r') . '.vim')
    if filereadable(s:plugin) | execute 'source' s:plugin | endif
endfor

execute 'augroup END'
