require('vis')

require('vis-commentary/vis-commentary')

vis.events.subscribe(vis.events.INIT, function()
    -- Your global configuration options
    vis:command('set tabwidth 4')
    vis:command('set expandtab on')
    vis:command('set autoindent on')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
    -- Your per window configuration options e.g.
    vis:command('set relativenumbers on')
end)
