local servers = { "sumneko_lua", "ccls" }

local function diagnostic_setup()
    local signs = {
        -- icons / text used for a diagnostic
        Error = "",
        Warn = "",
        Hint = "",
        Info = "",
    }
    for serverity, icon in pairs(signs) do
        local hl = "DiagnosticSign"..serverity
        vim.fn.sign_define(hl, {
            text = icon,
            texthl = hl,
            numhl = "",
        })
    end
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- local function buf_set_option(...)
    --     vim.api.nvim_buf_set_option(bufnr, ...)
    -- end

    -- Enable completion triggered by <c-x><c-o>
    -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- aerial.nvim
    require("aerial").on_attach(client, bufnr)
end

local setup = function()
    diagnostic_setup()
    require("nvim-lsp-installer").setup {
        ensure_installed = servers
    }

    local lspconfig = require('lspconfig')
    for _, server in ipairs(servers) do
        local opts = {
            on_attach = on_attach,
            flags = {
                debounce_text_changes = 150
            }
        }
        local ok, custom_opts = pcall(require, 'modules.completion.lspconfig.' .. server)
        if ok then
            opts = vim.tbl_deep_extend('force', opts, custom_opts)
        end
        lspconfig[server].setup(opts)
    end
end

return {
    setup = setup
}
