packadd fzf

let $FZF_DEFAULT_COMMAND = 'fd --type file --hidden --ignore-file '.$XDG_CONFIG_HOME.'/git/ignore'
nnoremap <Leader>f <cmd>FZF<CR>
