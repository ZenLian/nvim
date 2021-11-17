
local leader_map = function()
    vim.g.mapleader = " "
end

function init()
    leader_map()

    require('core.options')
    require('core.keymaps')
    require('core.pack')

    vim.cmd('colorscheme edge')
end

init()

