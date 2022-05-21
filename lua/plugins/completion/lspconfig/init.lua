local servers = { "sumneko_lua", "ccls" }

local on_attach = function(client, bufnr)
    require('plugins.completion.lspconfig.formatting').on_attach(client, bufnr)
    require('plugins.completion.lspconfig.keymaps').on_attach(client, bufnr)
    require('plugins.completion.lspconfig.signature').on_attach(client, bufnr)
    -- aerial.nvim
    require("aerial").on_attach(client, bufnr)
end

local setup = function()
    require('plugins.completion.lspconfig.diagnostic').setup()

    require("nvim-lsp-installer").setup {
        ensure_installed = servers
    }

    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    for _, server in ipairs(servers) do
        local opts = {
            on_attach = on_attach,
            capabilities = capabilities,
        }

        -- custom config in lspconfig/{server}.lua
        local ok, custom_opts = pcall(require, 'plugins.completion.lspconfig.' .. server)
        if ok then
            opts = vim.tbl_deep_extend('force', opts, custom_opts)
        end
        lspconfig[server].setup(opts)
    end
end

setup()
