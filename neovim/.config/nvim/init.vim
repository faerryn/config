" Autosourcing
augroup SourceInitVim
	autocmd!
	execute 'autocmd BufWritePost ' . expand('<sfile>')
				\ . ' source ' . expand('<sfile>')
augroup END

" Settings
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
set splitbelow splitright
set tabstop=4 softtabstop=4 shiftwidth=4
set termguicolors
set timeoutlen=250
set undofile
set updatetime=250
set wildmode=list:longest,full

" Some mappings
nnoremap <silent> <leader>c :copen<cr>
nnoremap <silent> <leader>d :bdelete<cr>
nnoremap <silent> <leader>l :lopen<cr>
nnoremap <silent> <leader>t :tabedit<cr>
nnoremap <silent> <leader>w :write<cr>

augroup QuickfixSettings
	autocmd!
	autocmd Filetype qf nnoremap <silent> <buffer> <esc> <c-w>q
augroup END

" Ask to install vim-plug on startup
if !exists('s:vim_plug_install_answer')
	if empty(glob(stdpath('data') . '/site/autoload/plug.vim'))
		echo 'Install plugins? [y/N]: '
		let s:vim_plug_install_answer = nr2char(getchar())
		if s:vim_plug_install_answer ==? 'y'
			let s:want_plugins = v:true
			execute "!curl -fLo " . stdpath('data')
						\ . '/site/autoload/plug.vim --create-dirs
						\ https://raw.githubusercontent.com/
						\junegunn/vim-plug/master/plug.vim'
			augroup VimplugAutoinstall
				autocmd!
				autocmd VimEnter * 
							\ | execute 'source ' . stdpath('config') . '/plugins.vim'
							\ | PlugInstall --sync
							\ | execute 'source ' . stdpath('config') . '/plugin_prefs.vim'
			augroup END
		endif
	else
		execute 'source ' . stdpath('config') . '/plugins.vim'
		execute 'source ' . stdpath('config') . '/plugin_prefs.vim'
	endif
endif
