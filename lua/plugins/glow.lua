local M = {
  packer = {
    cmd = 'Glow',
  },
}

M.packer.config = function()
  require('glow').setup {
    border = 'single',
    width_ratio = 0.9,
    height_ratio = 0.9,
    width = 120,
    height = 25,
  }
end

M.packer.init = function()
  local util = require('util')
  util.augroup {
    ['plugins.glow'] = {
      event = 'FileType',
      pattern = 'markdown',
      callback = function()
        util.keymap('n', '<leader>lp', '<cmd>Glow<cr>', {
          desc = 'Preview',
          buffer = true,
        })
      end,
    },
  }
end

return M
