local M = {
  packer = {
    ft = 'qf',
  },
}

function M.packer.config()
  local bqf = require('bqf')
  bqf.setup {
    preview = {
      border_chars = { '┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█' },
    },
    filter = {
      fzf = {
        extra_opts = { '--bind', 'ctrl-o:toggle-all', '--delimiter', '│' },
      },
    },
  }
end

return M
