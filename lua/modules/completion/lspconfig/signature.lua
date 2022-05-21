local M = {}

local util = require('core.util')

-- TODO: use ray-x/lsp_signature.nvim
M.on_attach = function(client, bufnr)
    local trigger_chars = client.server_capabilities.signatureHelpTriggerCharacters
    trigger_chars = { "," }
    for _, c in ipairs(trigger_chars) do
        util.map("i", c, function()
            vim.defer_fn(function()
                pcall(vim.lsp.buf.signature_help)
            end, 0)
            return c
        end, {
            noremap = true,
            silent = true,
            buffer = bufnr,
            expr = true,
        })
    end
end

return M
