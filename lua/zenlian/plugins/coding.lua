-- better editing in files
--
-- [flash.nvim]:            go to anywhere
-- [mini.pairs]:            auto pairs
-- [mini.ai]:               text objects
-- [mini.surround]:         surround
-- [ts-comments.nvim]:      comments
-- [grug-far.nvim]:         search and replace

return {
    {
      "folke/flash.nvim",
      tag = 'v2.1.0', -- 'main' branch will crash on ubuntu20.04
      event = 'VeryLazy',
      opts = {},
      keys = {
        { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
        { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
        { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
        { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
      }
    },

    {
        "echasnovski/mini.pairs",
        event = 'VeryLazy',
        opts = {
            modes = { insert = true, command = true, terminal = false },
            -- skip autopair when next character is one of these
            skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
            -- skip autopair when the cursor is inside these treesitter nodes
            skip_ts = { "string" },
            -- skip autopair when next character is closing pair
            -- and there are more closing pairs than opening pairs
            skip_unbalanced = true,
            -- better deal with markdown code blocks
            markdown = true,
        },
        config = function()
            require("mini.pairs").setup()
        end
    },

    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        dependencies = {
            "echasnovski/mini.extra",
            opts = {},
        },
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({ -- code block
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),       -- class
                    d = { "%f[%d]%d+" },                                                          -- digits
                    g = MiniExtra.gen_ai_spec.buffer(),                                           -- whole buffer
                    i = MiniExtra.gen_ai_spec.indent(),
                },
            }
        end,
    },

    {
        "echasnovski/mini.surround",
        opts = {
          mappings = {
            add = "gsa", -- Add surrounding in Normal and Visual modes
            delete = "gsd", -- Delete surrounding
            find = "gsf", -- Find surrounding (to the right)
            find_left = "gsF", -- Find surrounding (to the left)
            highlight = "gsh", -- Highlight surrounding
            replace = "gsr", -- Replace surrounding
            update_n_lines = "gsn", -- Update `n_lines`
          },
        },
        -- Populate the keys based on the user's options
        keys = function(plugin, keys)
            local opts = plugin.opts
            local mappings = {
                { "gs", desc = "Surround", mode = { "n", "v" } },
                { opts.mappings.add, desc = "Add Surrounding", mode = { "n", "v" } },
                { opts.mappings.delete, desc = "Delete Surrounding" },
                { opts.mappings.find, desc = "Find Right Surrounding" },
                { opts.mappings.find_left, desc = "Find Left Surrounding" },
                { opts.mappings.highlight, desc = "Highlight Surrounding" },
                { opts.mappings.replace, desc = "Replace Surrounding" },
                { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
            }
            return vim.list_extend(mappings, keys)
        end,
    },

    {
        "folke/ts-comments.nvim",
        event = "VeryLazy",
        opts = {},
    },

    {
        'MagicDuck/grug-far.nvim',
        opts = { headerMaxWidth = 80 },
        cmd = "GrugFar",
        keys = {
            {
                "<leader>sr",
                function()
                    local grug = require("grug-far")
                    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                    grug.open({
                        transient = true,
                        prefills = {
                            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                        },
                    })
                end,
                mode = { "n", "v" },
                desc = "Search and Replace",
            },
        },
    }
}
