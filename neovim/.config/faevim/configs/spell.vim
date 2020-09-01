set spell spellcapcheck=
execute 'silent! mkspell!' fnamemodify($MYVIMRC, ':h') . '/spell/*.add'
