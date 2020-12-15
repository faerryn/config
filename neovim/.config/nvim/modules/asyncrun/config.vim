packadd asyncrun.vim
command! -bang -nargs=* Make AsyncRun<bang> -strip -post=copen -program=make <args>
