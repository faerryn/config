if vim.fn.executable'rg' then
	vim.o.grepprg = '{2>/dev/null rg --hidden --ignore-file $XDG_CONFIG_HOME/rg/ignore --vimgrep $*}'
	vim.o.grepformat = '%f:%l:%c:%m'
end
