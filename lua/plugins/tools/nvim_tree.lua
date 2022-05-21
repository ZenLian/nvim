require("nvim-tree").setup({
    update_focused_file = {
        enable = true,
        -- update_cwd = true
    },
    filters = {
        custom = { ".git", "node_modules", ".cargo" }
    },
    view = {
        mappings = {
            list = {
                { key = "l", action = "edit" },
                { key = "h", action = "close_node" },
            }
        }
    }
})
