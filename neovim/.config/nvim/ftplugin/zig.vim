let &l:includeexpr='substitute(v:fname, "^([^.])$", "\1.zig", "")'
let &l:include='\v\@(import|cInclude)\(\"\zs[^\"]+\ze\"\)'
let &l:define='\v<(fn|const|var)>'
setlocal path+=/usr/lib/zig/std
