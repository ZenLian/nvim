local specs = {
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = function()
      local config = require('config')
      local opts = {
        autoclose = true,
        use_diagnostic_signs = true
      }
      if not config.icons.enabled then
        opts.icons = false
        opts.fold_open = '+'
        opts.fold_closed = '-'
      end
      return opts
    end,
  },
  {
    'folke/todo-comments.nvim',
    event = 'BufWinEnter',
    opts = {
      highlight = {
        before = '',
        keyword = 'bg',
        after = '',
      },
    },
  },
}

return specs
