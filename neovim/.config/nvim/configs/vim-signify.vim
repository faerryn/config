autocmd User SignifyAutocmds execute 'autocmd! signify' | autocmd signify BufWritePost * call sy#start()
