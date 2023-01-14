local spec = {
  'ellisonleao/glow.nvim',
  cmd = 'Glow',
  init = function()
    local util = require('util')
    util.augroup {
      ['plugins.glow'] = {
        event = 'FileType',
        pattern = 'markdown',
        callback = function()
          util.keymaps { ['<Leader>lp'] = { '<cmd>Glow<cr>', desc = 'Preview', buffer = true } }
        end,
      },
    }
  end,
  opts = {
    border = 'single',
    width_ratio = 0.9,
    height_ratio = 0.9,
    width = 120,
    height = 25,
  },
}

return { spec }
