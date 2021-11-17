local completion = {}

completion["neovim/nvim-lspconfig"] = {
    opt = true,
    event = "BufReadPre",
}

completion["hrsh7th/nvim-cmp"] = {
    opt = true,
    event = "InsertEnter",
    requires = {
        {"hrsh7th/cmp-nvim-lsp"},
        {"hrsh7th/cmp-vsnip"}
    }
}

completion["hrsh7th/vim-vsnip"] = {
    after = "nvim-cmp",
}

completion["windwp/nvim-autopairs"] = {
    after = "nvim-cmp",
}

--Plug 'hrsh7th/cmp-vsnip'
--Plug 'hrsh7th/vim-vsnip'

--Plug 'hrsh7th/cmp-nvim-lsp'
--Plug 'hrsh7th/cmp-buffer'
--Plug 'hrsh7th/cmp-path'
--Plug 'hrsh7th/cmp-cmdline'
--Plug 'hrsh7th/nvim-cmp'

return completion
