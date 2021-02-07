augroup Personal
	autocmd!
augroup END

let s:config_d = expand('<sfile>:p:h')
let s:data_d = stdpath('data')

function s:load_modules_packages(also_load_config) abort
	if !exists('g:loaded_minpac')
		packadd minpac
		call minpac#init({
					\'dir': s:data_d.'/site',
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
	if a:also_load_config
		call minpac#update('', {'do': 'ReloadConfigs'})
	else
		call minpac#update()
	endif
endfunction

function s:load_modules_config() abort
	for s:config_f in split(glob(s:config_d.'/modules/*/config.vim'), '\n')
		execute 'source' s:config_f
	endfor
endfunction

command! -bar ReloadConfigs call s:load_modules_config()
command! -bar ReloadPackages call s:load_modules_packages(v:false)

if !isdirectory(s:data_d.'/site/pack/minpac')
	call system('git clone --depth 1 https://github.com/k-takata/minpac.git '.s:data_d.'/site/pack/minpac/opt/minpac')
	call s:load_modules_packages(v:true)
else
	call s:load_modules_config()
endif
