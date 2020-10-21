let g:sandwich#recipes = [
			\{'buns': ['(', ')'], 'nesting': -1, 'linewise': 0, 'input': ['(', ')', 'b'] },
			\{ 'buns': ['{', '}'], 'nesting': -1, 'linewise': 0, 'input': ['{', '}', 'B'] },
			\{ 'buns': ['[', ']'], 'nesting': -1, 'linewise': 0, 'input': ['[', ']'] },
			\{ 'buns': ['<', '>'], 'nesting': -1, 'linewise': 0, 'input': ['<', '>'] },
      			\{ 'buns': 'sandwich#magicchar#t#tag()', 'listexpr': 1, 'kind': ['add'], 'action': ['add'], 'input': ['t'] },
      			\{ 'buns': 'sandwich#magicchar#t#tag()', 'listexpr': 1, 'kind': ['replace'], 'action': ['add'], 'input': ['t'] },
			\{ 'external': ["\<Plug>(textobj-sandwich-tag-i)", "\<Plug>(textobj-sandwich-tag-a)"], 'noremap': 0, 'kind': ['replace', 'query'], 'expr_filter': ['operator#sandwich#kind() ==# "replace"'], 'synchro': 1, 'input': ['t'] },
			\{ 'external': ["\<Plug>(textobj-sandwich-tag-i)", "\<Plug>(textobj-sandwich-tag-a)"], 'noremap': 0, 'kind': ['delete', 'textobj'], 'expr_filter': ['operator#sandwich#kind() !=# "replace"'], 'synchro': 1, 'linewise': 1, 'input': ['t'] },
			\]

let g:sandwich_no_default_key_mappings          = 1
let g:operator_sandwich_no_default_key_mappings = 1
let g:textobj_sandwich_no_default_key_mappings  = 1

packadd vim-sandwich
map <silent> sa <Plug>(operator-sandwich-add)
nmap <silent> sd <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
nmap <silent> sr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)
