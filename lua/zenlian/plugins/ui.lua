-- Description: UI plugins
--
-- [catppuccin/nvim]: theme
-- [which-key.nvim]: onscreen keymap hints
-- [bufferline.nvim]: bufferline
-- [heirline.nvim]: statusline
-- [rainbow-delimiters.nvim]: rainbow brackets

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
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            spec = {}
        },
        keys = {
            {
                '<leader>?',
                function()
                    require("which-key").show({
                        global = false
                    })
                end,
                desc = "Show local keymaps"
            },
            {
                "<c-w><space>",
                function()
                    require("which-key").show({ keys = "<c-w>", loop = true })
                end,
                desc = "Window Hydra Mode (which-key)",
            },
        }
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
                diagnostics_indicator = function(_, _, diag)
                    local icons = LazyVim.config.icons.diagnostics
                    local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                        .. (diag.warning and icons.Warn .. diag.warning or "")
                    return vim.trim(ret)
                end,
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
                ---@param opts bufferline.IconFetcherOpts
                get_element_icon = function(opts)
                    return LazyVim.config.icons.ft[opts.filetype]
                end,
            },
        },
        config = function(_, opts)
            require("bufferline").setup(opts)
            -- Fix bufferline when restoring a session
            vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
                callback = function()
                    vim.schedule(function()
                        pcall(nvim_bufferline)
                    end)
                end,
            })
        end,
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

    -- [NEW] rainbow
    {
        'HiPhish/rainbow-delimiters.nvim',
        event = 'VeryLazy',
        config = function()
            local rainbow = require('rainbow-delimiters')
            require('rainbow-delimiters.setup').setup {
                strategy = {
                    [''] = rainbow.strategy['global'],
                },
                query = {
                    [''] = 'rainbow-delimiters',
                    html = 'rainbow-tags',
                },
            }
        end,
    },

}
