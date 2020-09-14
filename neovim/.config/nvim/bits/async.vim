command! -nargs=* Make execute 'AsyncRun -program=make <args>'
command! -nargs=* Grep execute 'AsyncRun -program=grep <args>'
let g:asyncrun_open=10
