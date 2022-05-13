local servers = {"sumneko_lua", "ccls"}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = {
        noremap = true,
        silent = true
    }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- buf_set_keymap('n', '<space>lD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- buf_set_keymap('n', '<space>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- buf_set_keymap('n', '<space>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- buf_set_keymap('n', '<space>le', '<cmd>lua vim.diagnostic.show_line_diagnostics()<CR>', opts)
    -- buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    -- buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<Leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    buf_set_keymap("n", "gr", "<cmd>Lspsaga lsp_finder<cr>", opts)
    buf_set_keymap("n", "<Leader>lr", "<cmd>Lspsaga rename<cr>", opts)
    buf_set_keymap("n", "<Leader>lc", "<cmd>Lspsaga code_action<cr>", opts)
    buf_set_keymap("x", "<Leader>lc", ":<C-u>Lspsaga range_code_action<cr>", opts)
    buf_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
    buf_set_keymap("n", "<Leader>ll", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
    buf_set_keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
    buf_set_keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
    buf_set_keymap("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", {})
    buf_set_keymap("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {})
    buf_set_keymap("n", "gh", "<cmd>Lspsaga signature_help<cr>", opts)
    buf_set_keymap("n", "gd", "<cmd>Lspsaga preview_definition<cr>", opts)

    -- aerial.nvim
    require("aerial").on_attach(client, bufnr)
end

local setup = function()
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
