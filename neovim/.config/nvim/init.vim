" Autosourcing
augroup SourceVimConfig
	execute 'autocmd! BufWritePost ' . expand('<sfile>')
				\ . ' source ' . expand('<sfile>')
augroup END

" Ask to install vim-plug on startup
if !exists('s:should_install_vim_plug')
	execute 'source ' . stdpath('config') . '/prefs.vim'
	if empty(glob(stdpath('data') . '/site/autoload/plug.vim'))
		echo 'Install plugins? [y/N]: '
		let s:should_install_vim_plug = nr2char(getchar())
		if s:should_install_vim_plug ==? 'y'
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
		let s:should_install_vim_plug = 'n'
		execute 'source ' . stdpath('config') . '/plugins.vim'
		execute 'source ' . stdpath('config') . '/plugin_prefs.vim'
	endif
endif
