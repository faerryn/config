set hidden termguicolors

let s:faevim_d = expand('$XDG_CONFIG_HOME/faevim')
let s:plugged_d = fnamemodify($MYVIMRC, ':h') . '/plugged'

execute 'augroup Personal'
autocmd!

execute 'source' s:faevim_d . '/core.vim'
call plug#begin(s:plugged_d)
execute 'source' s:faevim_d . '/list.vim'
call plug#end()
let s:vim_plug_config = s:faevim_d . '/configs/vim-plug.vim'
execute 'source' s:vim_plug_config
if !isdirectory(s:plugged_d) | PlugInstall | endif

let s:guards = {}
let s:guards[s:vim_plug_config] = 1
for s:config in split(glob(s:faevim_d . '/configs/*.vim'), '\n')
    if !exists("s:guards['" . s:config . "']")
	execute 'source' s:config
	let s:guards[s:config] = 1
    endif
endfor

execute 'augroup END'
