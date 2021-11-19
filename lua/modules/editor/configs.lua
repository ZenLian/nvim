local configs = {}

configs["nvim-treesitter/nvim-treesitter"] = function()
    vim.cmd("set foldmethod=expr")
    vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
    require("nvim-treesitter.configs").setup {
        ensure_installed = "maintained",
        sync_install = false,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["a,"] = "@parameter.outer",
                    ["i,"] = "@parameter.inner",
                    ["ab"] = "@block.outer",
                    ["ib"] = "@block.inner",
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]]"] = "@function.outer",
                    ["]m"] = "@class.outer",
                },
                goto_next_end = {
                    ["]["] = "@function.outer",
                    ["]M"] = "@class.outer",
                },
                goto_previous_start = {
                    ["[["] = "@function.outer",
                    ["[m"] = "@class.outer",
                },
                goto_previous_end = {
                    ["[]"] = "@function.outer",
                    ["[M"] = "@class.outer",
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<Leader>s,"] = "@parameter.inner"
                },
                swap_previous = {
                    ["<Leader>s<"] = "@parameter.inner"
                }
            },
            lsp_interop = {
                enable = true,
                border = 'none',
                peek_definition_code = {
                    ["<leader>df"] = "@function.outer",
                    ["<leader>dF"] = "@class.outer",
                },
            },
        },
        rainbow = {
            enable = true,
            -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            max_file_lines = nil, -- Do not enable for files with more than n lines, int
            -- colors = {}, -- table of hex strings
            -- termcolors = {} -- table of colour name strings
        }
    }
end

configs["mfussenegger/nvim-treehopper"] = function()
    vim.cmd [[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]]
    vim.cmd [[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]
    require("tsht").config.hint_keys = { "j", "k", "l", "f", "d", "s", "h", "g", "m" }
end

configs["blackCauldron7/surround.nvim"] = function()
    require("surround").setup {mappings_style = "surround"}
end


return configs
