if has('find_in_path')
	let &l:includeexpr='substitute(v:fname, "^([^.])$", "\1.zig", "")'
	let &l:include='\v(\@import>|\@cInclude>|^\s*\#\s*include)'
	let &l:define='\v(<fn>|<const>|<var>|^\s*\#\s*define)'
endif
if has('eval')
	execute 'setlocal path+=' . json_decode(system('zig env'))['std_dir']
endif
