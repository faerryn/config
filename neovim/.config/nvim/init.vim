" Autosourcing
augroup SourceVimConfig
	execute 'autocmd! BufWritePost ' . expand('<sfile>')
				\ . ' source ' . expand('<sfile>')
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
							\ | execute 'source ' . stdpath('config') . '/prefs.vim'
							\ | execute 'source ' . stdpath('config') . '/plugins.vim'
							\ | PlugInstall --sync
							\ | execute 'source ' . stdpath('config') . '/plugin_prefs.vim'
			augroup END
		endif
	else
		let s:vim_plug_install_answer = 'n'
		execute 'source ' . stdpath('config') . '/prefs.vim'
		execute 'source ' . stdpath('config') . '/plugins.vim'
		execute 'source ' . stdpath('config') . '/plugin_prefs.vim'
	endif
endif
