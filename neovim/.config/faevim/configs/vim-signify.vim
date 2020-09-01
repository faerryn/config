autocmd User SignifyAutocmds execute 'au! signify' | autocmd signify BufWritePost * call sy#start()
autocmd BufEnter * SignifyRefresh
