augroup Personal
	autocmd!
augroup END

let s:config_d = expand('<sfile>:p:h')

function s:load_modules_packages() abort
	if !exists('g:loaded_minpac')
		packadd minpac
		call minpac#init({
					\'dir': stdpath('data').'/site',
					\'progress_open': 'none',
					\'status_open': 'none',
					\'status_auto': v:false,
					\'confirm': v:false,
					\})
		call minpac#add('k-takata/minpac', {'type': 'opt'})
	endif

	for s:packages_f in split(glob(s:config_d.'/modules/*/packages.vim'), '\n')
		execute 'source' s:packages_f
	endfor

	call minpac#clean()
	call minpac#update('', {'do': 'ReloadConfigs'})
endfunction

function s:load_modules_config() abort
	for s:config_f in split(glob(s:config_d.'/modules/*/config.vim'), '\n')
		execute 'source' s:config_f
	endfor
endfunction

function s:SID()
	return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
endfun
let s:sid = s:SID()

command! -bar ReloadConfigs call s:load_modules_config()
command! -bar ReloadPackages call s:load_modules_packages()

if !isdirectory(stdpath('data').'/site/pack/minpac')
	call system('git clone --depth 1 https://github.com/k-takata/minpac.git '.stdpath('data').'/site/pack/minpac/opt/minpac')
	call s:load_modules_packages()
else
	call s:load_modules_config()
endif
