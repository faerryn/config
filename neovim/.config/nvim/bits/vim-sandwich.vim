map <silent> sa <Plug>(operator-sandwich-add)
nmap <silent> sd <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nmap <silent> sr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
let g:sandwich#recipes=[
			\ {'buns': ['(', ')'], 'nesting': -1, 'linewise': 0, 'input': ['(', ')', 'b']},
			\ {'buns': ['{', '}'], 'nesting': -1, 'linewise': 0, 'input': ['{', '}', 'B']},
			\ {'buns': ['[', ']'], 'nesting': -1, 'linewise': 0},
			\ {'buns': ['<', '>'], 'nesting': -1, 'linewise': 0},
			\ ]
let g:sandwich_no_default_key_mappings=1
let g:operator_sandwich_no_default_key_mappings=1
let g:textobj_sandwich_no_default_key_mappings=1
