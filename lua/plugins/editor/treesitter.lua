vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "help", "vim", "lua", "comment", "dockerfile", "cuda", "regex",
        "bash", "c", "cpp", "make", "cmake",
        "go", "java", "python",
        "html", "css", "scss", "javascript", "typescript",
        "json", "json5", "jsonc", "toml", "yaml",
    },
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "g=",
            node_decremental = "g-",
            scope_incremental = "grc",
        }
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
                ["]c"] = "@class.outer",
                ["],"] = "@parameter.inner",
            },
            goto_next_end = {
                ["]["] = "@function.outer",
                ["]C"] = "@class.outer",
            },
            goto_previous_start = {
                ["[["] = "@function.outer",
                ["[c"] = "@class.outer",
                ["[,"] = "@parameter.inner",
            },
            goto_previous_end = {
                ["[]"] = "@function.outer",
                ["[C"] = "@class.outer",
            },
        },
        swap = {
            enable = false
        },
        lsp_interop = {
            enable = false,
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
