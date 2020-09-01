set spell spellcapcheck=
execute 'silent! mkspell!' luaeval('nvim_d') . '/spell/*.add'
