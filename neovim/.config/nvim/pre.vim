" vim-highlightedyank
" autocmd TextYankPost * lua vim.highlight.on_yank{timeout=500}
let g:highlightedyank_highlight_duration = 500

" vim-plug
let g:plug_window='split new'
let g:plug_pwindow='split'
autocmd FileType vim-plug nmap <Esc> q

" lightline.vim
let g:lightline = { 'colorscheme': 'gruvbox' }

" vim-fugitive
autocmd FileType fugitive nnoremap <buffer> <Esc> <C-W>c
nnoremap <Leader>g <Cmd>Git<CR>

" vim-sandwich
let g:sandwich_no_default_key_mappings=1
let g:operator_sandwich_no_default_key_mappings=1
let g:textobj_sandwich_no_default_key_mappings=1
let g:sandwich#recipes=[
	    \ {'buns': ['(', ')'], 'nesting': -1, 'linewise': 0, 'input': ['(', ')', 'b']},
	    \ {'buns': ['{', '}'], 'nesting': -1, 'linewise': 0, 'input': ['{', '}', 'B']},
	    \ {'buns': ['[', ']'], 'nesting': -1, 'linewise': 0},
	    \ {'buns': ['<', '>'], 'nesting': -1, 'linewise': 0},
	    \ ]
map  sa <Plug>(operator-sandwich-add)
nmap sd <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nmap sr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)

" swap.vim
let g:swap_no_default_key_mappings=1
nmap sh <Plug>(swap-prev)
nmap sl <Plug>(swap-next)

" undotree
let g:undotree_CustomUndotreeCmd='split'
let g:undotree_CustomDiffpanelCmd='"'
let g:undotree_HelpLine=0
nnoremap <Leader>u <Cmd>UndotreeShow<CR>:UndotreeFocus<CR><Cmd>set ft=undotree<CR>
autocmd FileType undotree nnoremap <buffer> <Esc> <Cmd>UndotreeHide<CR>
autocmd FileType undotree nnoremap <buffer> <C-W>c <Cmd>UndotreeHide<CR>

" zig.vim
let g:zig_fmt_autosave=1
