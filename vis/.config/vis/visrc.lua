require'vis'

local vis_commentary = require'plugins/vis-commentary'

local vis_surround = require'plugins/vis-surround'
vis_surround.prefix.add     = {"sa"}
vis_surround.prefix.change  = {"sr"}
vis_surround.prefix.delete  = {"sd"}

local vis_pairs = require'plugins/vis-pairs'
vis_pairs.autopairs = false

vis.events.subscribe(vis.events.INIT, function()
    -- Your global configuration options
    vis:command'set autoindent  on'
    vis:command'set expandtab   on'
    vis:command'set tabwidth    4'
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
    -- Your per window configuration options e.g.
    vis:command'set colorcolumn      80'
    vis:command'set cursorline       on'
    vis:command'set relativenumbers  on'
end)