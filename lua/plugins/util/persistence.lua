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
      desc = 'restore LAST session',
    },
    {
      '<leader>qd',
      function()
        require('persistence').stop()
      end,
      desc = 'STOP persistence',
    },
  },
}

return { spec }
