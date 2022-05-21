local completion = {}

completion["neovim/nvim-lspconfig"] = {
    -- opt = true,
    -- module = "lspconfig",
    event = "BufReadPre",
    config = function()
        require('modules.completion.lspconfig')
    end,
    requires = {
        "williamboman/nvim-lsp-installer",
        "folke/lua-dev.nvim"
    }
}

completion["hrsh7th/nvim-cmp"] = {
    opt = true,
    event = { "InsertEnter", "CmdlineEnter" },
    requires = { {
        "saadparwaiz1/cmp_luasnip",
        after = "LuaSnip"
    }, {
        "hrsh7th/cmp-buffer",
        after = "cmp_luasnip"
    }, {
        "hrsh7th/cmp-nvim-lsp",
        after = "cmp-buffer"
    }, {
        "hrsh7th/cmp-nvim-lsp-signature-help",
        after = "cmp-nvim-lsp"
    }, {
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        after = "cmp-nvim-lsp"
    }, {
        "hrsh7th/cmp-path",
        after = "cmp-nvim-lsp"
    }, {
        "hrsh7th/cmp-cmdline",
        after = "cmp-path"
    }, {
        "hrsh7th/cmp-calc",
        after = "cmp-cmdline"
    }, {
        "dmitmel/cmp-cmdline-history",
        after = "cmp-cmdline"
    }, {
        "uga-rosa/cmp-dictionary",
        module = "cmp_dictionary"
    } },
    config = function()
        require('modules.completion.cmp')
    end
}

completion["L3MON4D3/LuaSnip"] = {
    after = "nvim-cmp",
    requires = "rafamadriz/friendly-snippets",
    config = function()
        require('modules.completion.luasnip')
    end
}

completion["windwp/nvim-autopairs"] = {
    after = "nvim-cmp",
    config = function()
        require('modules.completion.autopairs')
    end
}

completion["stevearc/aerial.nvim"] = {
    module = "aerial",
    cmd = "AerialToggle",
    config = function()
        require('modules.completion.aerial')
    end
}

completion["folke/trouble.nvim"] = {
    requires = "kyazdani42/nvim-web-devicons",
    cmd = "Trouble",
    module = "trouble",
    config = function()
        require('modules.completion.trouble')
    end
}

return completion
