local notify = require('notify')

-- notify.setup {
--   stages = 'slide',
--   timeout = 2000,
--   -- Function called when a new window is opened,
--   -- use for changing win settings/config
--   on_open = nil,
--   -- Function called when a window is closed
--   on_close = nil,
-- }
notify.setup {
  timeout = 2000,
}

vim.notify = notify

--#region LSP progress
-- Utility functions shared between progress reports for LSP and DAP
-- local client_notifs = {}

-- local function get_notif_data(client_id, token)
--     if not client_notifs[client_id] then
--         client_notifs[client_id] = {}
--     end

--     if not client_notifs[client_id][token] then
--         client_notifs[client_id][token] = {}
--     end

--     return client_notifs[client_id][token]
-- end

-- local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

-- local function update_spinner(client_id, token)
--     local notif_data = get_notif_data(client_id, token)

--     if notif_data.spinner then
--         local new_spinner = (notif_data.spinner + 1) % #spinner_frames
--         notif_data.spinner = new_spinner

--         notif_data.notification = vim.notify(nil, nil, {
--             hide_from_history = true,
--             icon = spinner_frames[new_spinner],
--             replace = notif_data.notification,
--         })

--         vim.defer_fn(function()
--             update_spinner(client_id, token)
--         end, 100)
--     end
-- end

-- local function format_title(title, client_name)
--     return client_name .. (#title > 0 and ": " .. title or "")
-- end

-- local function format_message(message, percentage)
--     return (percentage and percentage .. "%\t" or "") .. (message or "")
-- end

-- -- LSP integration
-- local callback = function()
--     -- vim.notify(
--     --     vim.inspect(vim.lsp.util.get_progress_messages()),
--     --     'info'
--     -- )
--     for _, client in ipairs(vim.lsp.get_active_clients()) do
--         local messages = client.messages

--         for token, progress in pairs(messages.progress) do
--             local notif_data = get_notif_data(client.id, token)
--             if not notif_data.notification then
--                 -- begin
--                 local msg = format_message(progress.message, progress.percentage)
--                 local title = format_title(progress.title, messages.name)
--                 notif_data.notification = vim.notify(msg, "info", {
--                     title = title,
--                     icon = spinner_frames[1],
--                     timeout = false,
--                 })
--                 notif_data.spinner = 1
--                 update_spinner(client.id, token)
--             elseif not progress.done then
--                 -- report
--                 notif_data.notification = vim.notify(
--                     format_message(progress.message, progress.percentage),
--                     "info",
--                     {
--                         replace = notif_data.notification,
--                     }
--                 )
--             else
--                 -- done
--                 notif_data.notification = vim.notify(
--                     progress.message or "Complete", "info",
--                     {
--                         icon = "",
--                         replace = notif_data.notification,
--                         timeout = 3000,
--                     }
--                 )
--                 notif_data.spinner = nil
--             end
--         end
--     end
-- end

-- TODO: use fidget.nvim instead for less visual impact
-- vim.api.nvim_create_augroup("Notify", { clear = true })
-- vim.api.nvim_create_autocmd(
--     { "User" },
--     {
--         pattern = { "LspProgressUpdate" },
--         group = "Notify",
--         desc = "LSP progress notification",
--         callback = callback,
--     }
-- )
--#endregion

-- LSP
-- https://github.com/rcarriga/nvim-notify/wiki/Usage-Recipes#lsp-messages
local severity = {
  'error',
  'warn',
  'info',
  'info', -- map both hint and info to info?
}
vim.lsp.handlers['window/showMessage'] = function(_, method, params, _)
  vim.notify(method.message, severity[params.type])
end
