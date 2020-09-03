execute 'source' stdpath('config') . '/core.vim'

let s:plugged_d=stdpath('data') . '/plugged'
let s:plug_vim=stdpath('data') . '/site/autoload/plug.vim'

if !filereadable(s:plug_vim)
    let s:plug_doc = stdpath('data') . '/site/doc/plug.txt'
    execute 'silent !curl -fLo "' . s:plug_vim . '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    execute 'silent !curl -fLo "' . s:plug_doc . '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/doc/plug.txt'
    execute 'source' s:plug_vim
    execut 'helptag' fnamemodify(s:plug_doc, ':h')
endif

call plug#begin(s:plugged_d)
execute 'source' stdpath('config') . '/list.vim'
call plug#end()

if !isdirectory(s:plugged_d)
    execute 'source' stdpath('config') . '/configs/vim-plug.vim'
    PlugInstall
endif

for s:config in split(glob(stdpath('config') . '/configs/*.vim'), '\n')
    execute 'source' s:config
endfor
