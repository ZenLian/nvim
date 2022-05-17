local notify = require("notify")

notify.setup {
    stages = "slide",
    timeout = 2000,
    -- Function called when a new window is opened,
    -- use for changing win settings/config
    on_open = nil,
    -- Function called when a window is closed
    on_close = nil,
}

vim.notify = notify
