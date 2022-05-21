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

function M.on_attach(_, bufnr)
    vim.api.nvim_create_augroup("LspFormat", { clear = true })
    vim.api.nvim_create_autocmd(
        { "BufWritePre" },
        {
            buffer = bufnr,
            callback = function()
                if require('config').format_on_save then
                    vim.lsp.buf.formatting_sync(nil, 1000)
                end
            end
        }
    )
end

return M
