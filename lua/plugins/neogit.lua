local spec = {
  'TimUntersberger/neogit',
  cmd = 'Neogit',
  keys = {
    { '<leader>gg', '<cmd>Neogit<CR>', desc = 'Neogit' },
  },
  opts = {
    disable_commit_confirmation = true,
    -- kind = 'floating',
    signs = {
      -- section = { '', '' },
      -- item = { '', '' },
      -- hunk = { '', '' },
      --  
      --  
      --  
      --  
      --  
      section = { '', '' },
      item = { '', '' },
      hunk = { '', '' },
    },
    integrations = {
      diffview = true,
    },
  },
}

return { spec }
