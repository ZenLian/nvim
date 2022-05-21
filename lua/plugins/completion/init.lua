local completion = {}

completion["neovim/nvim-lspconfig"] = {
    -- opt = true,
    -- module = "lspconfig",
    event = "BufReadPre",
    config = function()
        require('plugins.completion.lspconfig')
    end,
    requires = {
        "williamboman/nvim-lsp-installer",
        "folke/lua-dev.nvim"
    }
}

completion["hrsh7th/nvim-cmp"] = {
    event = { "InsertEnter", "CmdlineEnter" },
    after = { "LuaSnip" },
    config = function()
        require('plugins.completion.cmp')
    end,
    requires = {
        {
            "L3MON4D3/LuaSnip",
            requires = "rafamadriz/friendly-snippets",
            config = function()
                require('plugins.completion.luasnip')
            end
        },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lsp-document-symbol" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/cmp-calc" },
        { "dmitmel/cmp-cmdline-history" },
        { "uga-rosa/cmp-dictionary" }
    },
}

completion["windwp/nvim-autopairs"] = {
    module = "nvim-autopairs",
    config = function()
        require('plugins.completion.autopairs')
    end
}

completion["stevearc/aerial.nvim"] = {
    module = "aerial",
    cmd = "AerialToggle",
    config = function()
        require('plugins.completion.aerial')
    end
}

completion["folke/trouble.nvim"] = {
    requires = "kyazdani42/nvim-web-devicons",
    cmd = "Trouble",
    module = "trouble",
    config = function()
        require('plugins.completion.trouble')
    end
}

return completion
