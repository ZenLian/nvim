local M = {}

function M.config()
  require('drex.config').configure {
    hide_cursor = false,
    hijack_netrw = true,
    drawer = {
      default_width = 30,
      window_picker = {
        enabled = true,
        labels = 'jklhfdsgamiounewrcvtybxz',
      },
    },
    keybindings = {},
    on_enter = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.buflisted = false
      vim.opt_local.winhighlight = 'Normal:NeoTreeNormal,NormalNC:NeoTreeNormal'
    end,
  }
end

return M
