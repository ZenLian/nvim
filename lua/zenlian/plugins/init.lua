return {
    { "folke/lazy.nvim", version = "*" },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        init = function ()
            vim.g.snacks_animate = false
        end,
        opts = {
            bigfile = { enabled = true },
            quickfile = { enabled = true },
            indent = { enabled = true },
        }
    }
}
