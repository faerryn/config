"" Copyright (c) 2020 Jiang Meng Liao (Faerryn) <alexandre.liao@gmail.com>
"" 
"" Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
"" 
"" The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
"" 
"" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

let s:plugin_list_f = stdpath('config') . '/plugin_list.vim'
let s:bits_d = stdpath('config') . '/bits'
let s:plug_vim = stdpath('data') . '/site/autoload/plug.vim'
let s:plugged_d = stdpath('data') . '/plugged'
let s:plug_doc = stdpath('data') . '/site/doc/plug.txt'

function! s:try_source(source_file) abort
	if !filereadable(a:source_file) | return | endif
	let l:file_extension = fnamemodify(a:source_file, ':e')
	if l:file_extension == 'vim'
		execute 'try | source' a:source_file '| catch | echomsg v:exception | endtry'
	elseif l:file_extension == 'lua'
		execute 'try | luafile' a:source_file '| catch | echomsg v:exception | endtry'
	endif
endfunction

function! s:enhanced_source(source_file) abort
	if !filereadable(a:source_file) | return | endif
	let l:resolved_file = resolve(a:source_file)
	execute 'augroup Personal_' . substitute(l:resolved_file, '\/\|\.', '_', 'g')
	autocmd!
	call s:try_source(l:resolved_file)
	execute 'autocmd BufWritePost' l:resolved_file 'call s:try_source("' . l:resolved_file . '")'
	execute 'augroup END'
endfunction

augroup PersonalInit
	autocmd!
	execute 'autocmd PersonalInit BufWritePost' resolve($MYVIMRC) 'source $MYVIMRC'
augroup END

""" CORE
call s:enhanced_source(stdpath('config') . '/core.vim')
call s:enhanced_source(stdpath('config') . '/core.lua')

""" VIM-PLUG
let g:plug_window = 'new'
let g:plug_pwindow = 'new'
autocmd PersonalInit FileType vim-plug nnoremap <silent> <buffer> <Esc> <C-W>c

let s:plug_vim = stdpath('data') . '/site/autoload/plug.vim'
let s:plug_doc = stdpath('data') . '/site/doc/plug.txt'
if !filereadable(s:plug_vim)
	execute 'silent !curl -fLo "' . s:plug_vim . '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	execute 'silent !curl -fLo "' . s:plug_doc . '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/doc/plug.txt'
	execute 'helptag' fnamemodify(s:plug_doc, ':p:h')
endif

""" PLUG_LIST
function! s:load_list() abort
	call plug#begin(s:plugged_d)
	call s:try_source(s:plugin_list_f)
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
