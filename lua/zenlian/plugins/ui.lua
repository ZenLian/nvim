-- Description: UI plugins
--
-- [catppuccin/nvim]: theme
-- [bufferline.nvim]: bufferline
-- [heirline.nvim]: statusline
return {
    {
        "catppuccin/nvim",
        lazy = true,
        name = "catppuccin",
        opts = {
            flavour = 'mocha',
            term_colors = true,
        },
        config = function(_, opts)
            local catppuccin = require('catppuccin')
            local C = require('catppuccin.palettes').get_palette(opts.flavour)
            opts.custom_highlights = {
                -- Pmenu = { fg = C.text, bg = C.surface0 },
                -- PmenuSel = { fg = C.surface0, bg = C.blue },
                CmpItemAbbr = { fg = C.text },
                CmpItemAbbrMatch = { fg = C.blue, style = { 'bold' } },
                CmpItemAbbrMatchFuzzy = { fg = C.blue, style = { 'bold' } },

                -- flash.nvim
                FlashLabel = { fg = C.base, bg = C.green },
            }

            catppuccin.setup(opts)
        end,
    },

    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle Pin" },
            { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
            { "<leader>br", "<Cmd>BufferLineCloseRight<CR>",           desc = "Delete Buffers to the Right" },
            { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>",            desc = "Delete Buffers to the Left" },
            { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
            { "<S-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
            { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
            { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
            { "[B",         "<cmd>BufferLineMovePrev<cr>",             desc = "Move buffer prev" },
            { "]B",         "<cmd>BufferLineMoveNext<cr>",             desc = "Move buffer next" },
        },
        opts = {
            options = {
                -- stylua: ignore
                close_command = function(n) Snacks.bufdelete(n) end,
                -- stylua: ignore
                right_mouse_command = function(n) Snacks.bufdelete(n) end,
                diagnostics = "nvim_lsp",
                always_show_bufferline = false,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                    },
                    {
                        filetype = "snacks_layout_box",
                    },
                },
            },
        },
    },

    {
        'rebelot/heirline.nvim',
        enabled = false,
        event = 'UIEnter',
        opts = function()
            local C = require('catppuccin.palettes').get_palette()
            return {
                colors = C,
            }
        end,
        config = function(_, opts)
            require('heirline').load_colors(opts.colors)
            local conditions = require('heirline.conditions')
            local components = require('zenlian.util').heirline

            local defaultStatusline = {
                components.mode('█  '),
                components.root_dir { cwd = true, color = 'pink' },
                components.filetype { icon_only = true },
                components.filepath { modified_color = 'green' },
                components.fileflags {},
                components.trim,
                components.align,

                components.noice_command { color = 'mauve' },
                components.noice_mode { color = 'peach' },
                components.lsp { color = 'maroon' },
                -- components.lazy_status { color = 'maroon' },
                components.git { color = 'rosewater' },
                components.ruler { color = 'subtext0' },
                components.mode('█'),
            }

            local alphaStatusline = {
                condition = function()
                    return conditions.buffer_matches {
                        filetype = { 'alpha', 'dashboard', 'starter' },
                    }
                end,
                components.mode('█  '),
                {
                    provider = function()
                        return vim.bo.filetype
                    end,
                },
                components.align,
                components.nvim_version(),
                components.mode('█'),
            }

            local neotreeStatusline = {
                condition = function()
                    return vim.tbl_contains({ 'neo-tree' }, vim.bo.filetype)
                end,
                components.mode('█ 󰝰 '),
                components.workdir { color = 'pink' },
                components.align,
                components.mode('█'),
            }

            local statusline = {
                hl = { fg = 'text', bg = 'base' },
                fallthrough = false,
                alphaStatusline,
                neotreeStatusline,
                defaultStatusline,
            }

            require('heirline').setup {
                statusline = statusline,
            }
        end,
    },

}
