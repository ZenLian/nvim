local M = {}

M.setup = function(options)
    require('edgeme.config').update(options)
end

-- apply colorscheme
M.load = function()
    local util = require('edgeme.util')
    local theme = require('edgeme.theme')
    util.load(theme)
end

return M
