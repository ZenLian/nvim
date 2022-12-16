local M = {
  packer = {
    opt = true,
    event = { 'BufWinEnter' },
  },
}

M.packer.config = function()
  require('todo-comments').setup {
    highlight = {
      before = '',
      keyword = 'bg',
      after = '',
    },
  }
end

return M
