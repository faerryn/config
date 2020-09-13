"" Copyright (c) 2020 Jiang Meng Liao (Faerryn) <alexandre.liao@gmail.com>
"" 
"" Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
"" 
"" The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
"" 
"" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

let s:config_d=stdpath('config')
let s:data_d=stdpath('data')

let s:plugin_list_f=s:config_d . '/plugin_list.vim'
let s:bits_d=s:config_d . '/bits'
let s:plug_vim=s:data_d . '/site/autoload/plug.vim'
let s:plugged_d=s:data_d . '/plugged'
let s:plug_doc=s:data_d . '/site/doc/plug.txt'

function! s:enhanced_source(file) abort
	if !filereadable(a:file) | return | endif
	let l:resolved_file=resolve(a:file)
	let l:file_extension=fnamemodify(l:resolved_file, ':e')
	execute 'augroup Personal_' . substitute(l:resolved_file, '\/\|\.', '_', 'g')
	autocmd!
	if l:file_extension == 'vim'
		execute 'try | source' l:resolved_file '| catch | echomsg v:exception | endtry'
		execute 'autocmd BufWritePost' l:resolved_file 'try | source' l:resolved_file '| catch | echomsg v:exception | endtry'
	elseif l:file_extension == 'lua'
		try | execute 'luafile' l:resolved_file | catch | echomsg v:exception | endtry
		execute 'autocmd BufWritePost' l:resolved_file 'try | execute "luafile' l:resolved_file . '" | catch | echomsg v:exception | endtry'
	endif
	execute 'augroup END'
endfunction

augroup PersonalInit
	autocmd!
	execute 'autocmd BufWritePost' resolve($MYVIMRC) 'source $MYVIMRC'
	autocmd PersonalInit FileType vim-plug nnoremap <silent> <buffer> <Esc> <C-W>c
augroup END

""" CORE
call s:enhanced_source(s:config_d . '/core.vim')
call s:enhanced_source(s:config_d . '/core.lua')

""" VIM-PLUG
let g:plug_window='split new'
let g:plug_pwindow='split new'

let s:plug_vim=s:data_d . '/site/autoload/plug.vim'
let s:plug_doc=s:data_d . '/site/doc/plug.txt'
if !filereadable(s:plug_vim)
	execute 'silent !curl -fLo "' . s:plug_vim . '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	execute 'silent !curl -fLo "' . s:plug_doc . '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/doc/plug.txt'
	execute 'helptag' fnamemodify(s:plug_doc, ':p:h')
endif

""" PLUG_LIST
function! s:load_list() abort
	call plug#begin(s:plugged_d)
	try | execute 'source' s:plugin_list_f | catch | echo v:exception | endtry
	call plug#end()
endfunction
call s:load_list()
execute 'autocmd PersonalInit BufWritePost' resolve(s:plugin_list_f) 'call s:load_list()'

if !isdirectory(s:plugged_d)
	PlugInstall
endif

""" BITS
for s:config_f in split(glob(s:bits_d . '/*.{vim,lua}'), '\n')
	call s:enhanced_source(s:config_f)
endfor
