local M = {}

function M.setup(on_attach)
    require("null-ls").setup {
        sources = {
            -- require("null-ls").builtins.formatting.stylua,
            -- require("null-ls").builtins.completion.spell,
            require("null-ls").builtins.diagnostics.eslint,
            -- markdown
            require("null-ls").builtins.diagnostics.markdownlint,
            require("null-ls").builtins.formatting.markdownlint,
        },
        on_attach = on_attach,
    }
end

return M
