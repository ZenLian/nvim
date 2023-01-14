local spec = {
  'AckslD/nvim-FeMaco.lua',
  cmd = 'FeMaco',
  init = function()
    local util = require('util')
    util.augroup {
      ['plugins.femaco'] = {
        event = 'FileType',
        pattern = 'markdown',
        callback = function()
          util.keymaps({
            ['<Leader>li'] = { '<cmd>FeMaco<cr>', desc = 'Edit codeblock' },
            ['<C-l>'] = { '<cmd>FeMaco<cr>', desc = 'Edit codeblock', mode = 'i' },
          }, { buffer = true })
        end,
      },
    }
  end,
  opts = {
    post_open_float = function(_)
      vim.wo.signcolumn = 'no'
      local util = require('util')
      -- esc to close
      util.keymaps({ ['<esc>'] = { '<cmd>q<cr>' } }, { buffer = true })
    end,
  },
}

return { spec }
