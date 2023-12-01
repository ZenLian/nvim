local spec = {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {},
  keys = {
    {
      '<leader>qs',
      function()
        require('persistence').load()
      end,
      desc = 'restore session for CWD',
    },
    {
      '<leader>ql',
      function()
        require('persistence').load { last = true }
      end,
      desc = 'restore last session',
    },
    {
      '<leader>qd',
      function()
        require('persistence').stop()
      end,
      desc = 'restore session for CWD',
    },
  },
}

return { spec }
