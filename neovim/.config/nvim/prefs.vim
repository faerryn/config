" Autosourcing
augroup SourceVimConfig
	execute 'autocmd! BufWritePost ' . expand('<sfile>')
				\ . ' source ' . expand('<sfile>')
augroup END

let g:mapleader=' '
set cindent
set cursorline cursorcolumn
set foldmethod=syntax foldlevelstart=20
set hidden
set ignorecase smartcase
set lazyredraw
set mouse=ar
set nowrap
set number relativenumber
set omnifunc=syntaxcomplete#Complete
set signcolumn=yes
set spell
set splitbelow splitright
set tabstop=4 softtabstop=4 shiftwidth=4
set termguicolors
set timeoutlen=250
set undofile
set updatetime=250

nnoremap <silent> <leader>q :copen<cr>
nnoremap <silent> <leader>l :lopen<cr>
nnoremap <silent> [b :bprevious<cr>
nnoremap <silent> ]b :bnext<cr>

augroup QuickfixSettings
	autocmd!
	autocmd FileType qf nnoremap <silent> <buffer> <esc> <c-w>q
augroup END

function! s:rustfmt_fallback()
	if !exists('g:rustfmt_autosave')
		%!rustfmt
	endif
endfunction
augroup FormatOnWrite
	autocmd!
	if executable("clang-format")
		autocmd BufWritePre *.c,*.cpp %!clang-format
	endif
	if executable("rustfmt")
		autocmd BufWritePre *.rs call s:rustfmt_fallback()
	endif
augroup END
