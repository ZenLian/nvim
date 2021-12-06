local configs = {}

configs.treesitter = function()
    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "nvim_treesitter#foldexpr()"
    require("nvim-treesitter.configs").setup {
        -- ensure_installed = "maintained",
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
                    ["aa"] = "@parameter.outer",
                    ["ia"] = "@parameter.inner",
                    ["ab"] = "@block.outer",
                    ["ib"] = "@block.inner",
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]]"] = "@function.outer",
                    ["]c"] = "@class.outer",
                    ["]a"] = "@parameter.inner",
                },
                goto_next_end = {
                    ["]["] = "@function.outer",
                    ["]C"] = "@class.outer",
                },
                goto_previous_start = {
                    ["[["] = "@function.outer",
                    ["[c"] = "@class.outer",
                    ["[a"] = "@parameter.inner",
                },
                goto_previous_end = {
                    ["[]"] = "@function.outer",
                    ["[C"] = "@class.outer",
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<Leader>]a"] = "@parameter.inner"
                },
                swap_previous = {
                    ["<Leader>[a"] = "@parameter.inner"
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

configs.treehopper = function()
    vim.cmd [[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]]
    vim.cmd [[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]
    require("tsht").config.hint_keys = { "j", "k", "l", "f", "d", "s", "h", "g", "m" }
end

configs.gitsigns = function ()
    require("gitsigns").setup {
        keymaps = {
            buffer = true,
            noremap = true,

            ['n ]g'] = { expr = true, "&diff ? ']h' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
            ['n [g'] = { expr = true, "&diff ? '[h' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},
            ['n <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
            ['v <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
            ['n <leader>gu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
            ['n <leader>gr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
            ['v <leader>gr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
            ['n <leader>gR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
            ['n <leader>gp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
            ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
            ['n <leader>gS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
            ['n <leader>gU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',
            -- Text objects
            ['o ig'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
            ['o ag'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
            ['x ig'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
            ['x ag'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
        },
        current_line_blame = true,
        current_line_blame_opts = {delay = 1000, virtual_text_pos = "eol"},
    }
end

configs.lightspeed = function ()
    vim.cmd [[nmap <silent>; <Plug>Lightspeed_;_ft]]
    vim.cmd [[nmap <silent>, <Plug>Lightspeed_,_ft]]
end

return configs
