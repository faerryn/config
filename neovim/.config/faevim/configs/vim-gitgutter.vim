let g:gitgutter_map_keys=0
if !&diff
    nmap ]c <Plug>(GitGutterNextHunk)
    nmap [c <Plug>(GitGutterPrevHunk)
endif
