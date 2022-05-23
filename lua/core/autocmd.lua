local augroup = function(name)
    vim.api.nvim_create_augroup(name, { clear = true })
end
local autocmd = vim.api.nvim_create_autocmd

augroup("edit")
-- return to last edit position
autocmd(
    { "BufReadPost" },
    {
        -- command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]],
        group = "edit",
        callback = function()
            local pos = vim.fn.line([['"]])
            if pos > 1 and pos <= vim.fn.line("$") then
                vim.cmd [[normal! g'"]]
            end
        end,
    }
)

-- highlight on yank
autocmd(
    { "TextYankPost" },
    {
        -- command = [[ silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150} ]],
        group = "edit",
        callback = function()
            vim.highlight.on_yank() --{ higroup = "IncSearch", timeout = 250 }
        end
    }
)

-- hide cursorline for unfocused window
autocmd(
    { "WinEnter" },
    {
        group = "edit",
        pattern = { "!TelescopePrompt" },
        callback = function()
            vim.wo.cursorline = true
        end
    }
)
autocmd(
    { "WinLeave" },
    {
        group = "edit",
        pattern = { "!TelescopePrompt" },
        callback = function()
            vim.wo.cursorline = false
        end
    }
)

-- equalize window when vim window resized
autocmd(
    { "VimResized" },
    {
        group = "edit",
        -- command = [[tabdo wincmd =]]
        command = [[wincmd =]]
    }
)

-- auto reload file change
-- FIXME: FocusGained event not working
autocmd(
    { "FocusGained" },
    {
        command = [[checktime]],
    }
)

-- windows to close with "q"
vim.cmd([[autocmd FileType help,startuptime,qf,lspinfo,notify nnoremap <buffer><silent> q :close<CR>]])
vim.cmd([[autocmd FileType man nnoremap <buffer><silent> q :quit<CR>]])

-- markdown spell on
-- vim.cmd([[autocmd FileType markdown setlocal spell]])
