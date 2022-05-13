local completion = {}
local configs = require("modules.completion.configs")

completion["neovim/nvim-lspconfig"] = {
    opt = true,
    event = { "BufRead", "BufNewFile" }
}

completion["williamboman/nvim-lsp-installer"] = {
    after = "nvim-lspconfig",
    config = configs.lsp_installer,
}

-- completion["ray-x/navigator.lua"] = {
--     requires = {
--         { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' }
--     }
-- }

completion["hrsh7th/nvim-cmp"] = {
    opt = true,
    event = { "InsertEnter", "CmdlineEnter" },
    requires = {
        { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
        { "hrsh7th/cmp-buffer", after = "cmp_luasnip" },
        { "hrsh7th/cmp-nvim-lsp", after = "cmp-buffer" },
        { "hrsh7th/cmp-nvim-lsp-signature-help", after = "cmp-nvim-lsp" },
        { "hrsh7th/nvim-lsp-document-symbol", after = "cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua", after = "cmp-nvim-lsp" },
        { "hrsh7th/cmp-path", after = "cmp-nvim-lua" },
        { "hrsh7th/cmp-cmdline", after = "cmp-path" },
        { "hrsh7th/cmp-calc", after = "cmp-cmdline" },
        { "dmitmel/cmp-cmdline-history", after = "cmp-cmdline" },
        { "uga-rosa/cmp-dictionary", module = "cmp_dictionary" },
    },
    config = configs.cmp,
}

completion["L3MON4D3/LuaSnip"] = {
    after = "nvim-cmp",
    requires = "rafamadriz/friendly-snippets",
    config = configs.luasnip,
}

completion["windwp/nvim-autopairs"] = {
    after = "nvim-cmp",
    config = configs.autopairs,
}

completion["stevearc/aerial.nvim"] = {
    module = "aerial",
    config = function()
        require("aerial").setup {
            -- A list of all symbols to display. Set to false to display all symbols.
            -- This can be a filetype map (see :help aerial-filetype-map)
            -- To see all available values, see :help SymbolKind
            filter_kind = false,
            --     "Class",
            --     "Constructor",
            --     "Enum",
            --     "Function",
            --     "Interface",
            --     "Module",
            --     "Method",
            --     "Struct",
            -- },
            highlight_on_hover = true,
            manage_folds = true,
            min_width = 15,
        }
    end
}

completion["folke/trouble.nvim"] = {
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
        require("trouble").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    end
}

return completion
