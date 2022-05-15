
local leader_map = function()
    vim.g.mapleader = " "
end

local function init()

    require('core.options')
    leader_map()
    -- require('core.keymaps')
    require('core.pack')

    vim.cmd [[colorscheme edgeme]]
end

init()

