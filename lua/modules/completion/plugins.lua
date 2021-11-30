local completion = {}

completion["neovim/nvim-lspconfig"] = {
    opt = true,
    event = "BufRead",
}

completion["williamboman/nvim-lsp-installer"] = {
    opt = true,
    after = "nvim-lspconfig"
}

completion["hrsh7th/nvim-cmp"] = {
    opt = true,
    event = {"InsertEnter", "CmdlineEnter"},
    requires = {
        {"saadparwaiz1/cmp_luasnip", after = "LuaSnip"},
        {"hrsh7th/cmp-buffer", after = "cmp_luasnip"},
        {"hrsh7th/cmp-nvim-lsp", after = "cmp-buffer"},
        {"hrsh7th/cmp-nvim-lua", after = "cmp-nvim-lsp"},
        {"hrsh7th/cmp-path", after = "cmp-nvim-lua"},
        {"hrsh7th/cmp-cmdline", after = "cmp-path"},
        {"hrsh7th/cmp-calc", after = "cmp-cmdline"},
        {"uga-rosa/cmp-dictionary", after = "cmp-calc"},
    }
}

completion["L3MON4D3/LuaSnip"] = {
    after = "nvim-cmp",
    requires = "rafamadriz/friendly-snippets"
}

completion["windwp/nvim-autopairs"] = {
    after = "nvim-cmp",
}

return completion
