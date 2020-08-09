require'vis'

require'vis-commentary'
require'vis-complete-line'

local vis_pairs = require'vis-pairs'
vis_pairs.autopairs = false

local vis_surround = require'vis-surround'
vis_surround.prefix.add    = {"sa", "sa"}
vis_surround.prefix.change = {"sr", "sr"}
vis_surround.prefix.delete = {"sd", "sd"}

vis.events.subscribe(vis.events.INIT, function()
    -- Your global configuration options
    vis:command'map   normal Q @@'
    vis:command'unmap normal s'
    vis:command'unmap normal S'
    vis:command'unmap visual s'
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
    -- Your per window configuration options e.g.
    vis:command'set colorcolumn 80 set cursorline on'
    vis:command'set relativenumbers on'
end)
