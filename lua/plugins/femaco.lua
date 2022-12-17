local M = {
  packer = {
    cmd = 'FeMaco',
  },
}

M.packer.config = function()
  require('femaco').setup {
    post_open_float = function(winnr)
      vim.wo.signcolumn = 'no'
      -- esc to close
      vim.keymap.set('n', '<esc>', '<cmd>q<cr>', { buffer = true, noremap = true, silent = true })
    end,
  }
end

M.packer.init = function()
  local util = require('util')
  util.augroup {
    ['plugins.femaco'] = {
      event = 'FileType',
      pattern = 'markdown',
      callback = function()
        util.keymap('n', '<leader>li', '<cmd>FeMaco<cr>', {
          desc = 'Edit code block',
          buffer = true,
        })
        util.keymap('i', '<C-l>', '<cmd>FeMaco<cr>', {
          desc = 'Edit code block',
          buffer = true,
        })
      end,
    },
  }
end

return M
