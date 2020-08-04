require'vis'

local commentary = require'vis-commentary/vis-commentary'

local surround = require'vis-surround'
surround.prefix.add = {"sa"}
surround.prefix.change = {"sr"}
surround.prefix.delete = {"sd"}

vis.events.subscribe(vis.events.INIT, function()
    -- Your global configuration options
    vis:command'set autoindent on'
    vis:command'set expandtab on'
    vis:command'set tabwidth 4'
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
    -- Your per window configuration options e.g.
    vis:command'set colorcolumn 80'
    vis:command'set cursorline on'
    vis:command'set relativenumbers on'
end)