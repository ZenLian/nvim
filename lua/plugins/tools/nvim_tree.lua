require("nvim-tree").setup({
    update_focused_file = {
        enable = true,
        -- update_cwd = true
    },
    filters = {
        custom = { "^\\.git" },
    },
    view = {
        width = 30,
        mappings = {
            list = {
                { key = "l", action = "edit" },
                { key = "h", action = "close_node" },
            }
        }
    }
})

-- https://github.com/romgrk/barbar.nvim#integration-with-filetree-plugins
local nvim_tree_events = require('nvim-tree.events')
local bufferline_state = require('bufferline.state')

nvim_tree_events.on_tree_open(function()
    bufferline_state.set_offset(30, "File Tree")
end)

nvim_tree_events.on_tree_close(function()
    bufferline_state.set_offset(0)
end)
