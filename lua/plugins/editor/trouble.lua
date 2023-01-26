local specs = {
  {
    'folke/trouble.nvim',
    dependencies = 'nvim-web-devicons',
    cmd = 'Trouble',
    opts = {
      autoclose = true,
    },
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
