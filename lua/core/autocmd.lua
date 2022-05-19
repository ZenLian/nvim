-- vim.api.nvim_create_augroup("edit", {})

-- return to last edit position
vim.api.nvim_create_autocmd(
    { "BufReadPost" },
    {
    -- command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]],
    callback = function()
        local pos = vim.fn.line([['"]])
        if pos > 1 and pos <= vim.fn.line("$") then
            vim.cmd [[normal! g'"]]
        end
    end,
}
)

-- highlight on yank
vim.api.nvim_create_autocmd(
    { "TextYankPost" },
    {
    -- command = [[ silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150} ]],
    callback = function()
        vim.highlight.on_yank { higroup = "IncSearch", timeout = 250 }
    end
}
)

-- hide cursorline for unfocused window
vim.api.nvim_create_augroup("window", { clear = true })
vim.api.nvim_create_autocmd(
    { "WinEnter" },
    {
    group = "window",
    callback = function()
        if not vim.wo.cursorline then
            vim.wo.cursorline = true
        end
    end
}
)
vim.api.nvim_create_autocmd(
    { "WinLeave" },
    {
    group = "window",
    callback = function()
        if vim.wo.cursorline then
            vim.wo.cursorline = false
        end
    end
}
)

-- equalize window when vim window resized
vim.api.nvim_create_autocmd(
    { "VimResized" },
    {
    group = "window",
    -- command = [[tabdo wincmd =]]
    command = [[wincmd =]]
}
)

-- auto reload file change
-- FIXME: FocusGained event not working
vim.api.nvim_create_autocmd(
    { "FocusGained" },
    {
    command = [[checktime]],
}
)

-- format on save
vim.api.nvim_create_augroup("save", { clear = true })
vim.api.nvim_create_autocmd(
    {"BufWritePre"},
    {
        group = "save",
        callback = function ()
            if require('config').format_on_save then
                vim.lsp.buf.formatting_sync(nil, 1000)
            end
        end
    }
)
