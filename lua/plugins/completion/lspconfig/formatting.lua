local M = {}
local config = require('config')

function M.format()
    if config.format_on_save then
        vim.lsp.buf.formatting_sync(nil, 2000)
    end
end

function M.toggle()
    config.format_on_save = not config.format_on_save
    if config.format_on_save then
        vim.notify("Enabled format on save", "info", {
            title = "Formatting"
        })
    else
        vim.notify("Disabled format on save", "warn", {
            title = "Formatting"
        })
    end
end

local augroup = vim.api.nvim_create_augroup("LspFormat", { clear = true })
function M.on_attach(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd(
            { "BufWritePre" },
            {
                group = augroup,
                buffer = bufnr,
                callback = M.format,
            }
        )
    end
end

return M
