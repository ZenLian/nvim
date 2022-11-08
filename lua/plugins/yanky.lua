local config = function()
  require('yanky').setup {
    ring = {
      storage = 'sqlite',
    },
    picker = {
      select = {
        action = nil, -- nil to use default put action
      },
      telescope = {
        mappings = nil, -- nil to use default mappings
      },
    },
    system_clipboard = {
      sync_with_ring = false,
    },
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 300,
    },
    preserve_cursor_position = {
      enabled = true,
    },
  }
end

return { config = config }
