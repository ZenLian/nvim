local M = {
  packer = {
    module = 'peek',
    run = { 'deno task --quiet build:fast' },
  },
}

M.packer.config = function()
  require('peek').setup()
end

M.packer.init = function()
  local util = require('util')
  util.augroup {
    ['plugins.peek'] = {
      event = 'FileType',
      pattern = 'markdown',
      callback = function()
        util.keymap('n', '<leader>lP', '<cmd>lua require("plugins.peek").toggle()<cr>', {
          desc = 'Preview(live)',
          buffer = true,
        })
      end,
    },
  }
end

function M.toggle()
  local peek = require('peek')
  if peek.is_open() then
    peek.close()
  else
    peek.open()
  end
end

return M
