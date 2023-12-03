return {
  {
    'NeogitOrg/neogit',
    cmd = 'Neogit',
    keys = {
      { '<leader>G', '<cmd>Neogit<CR>', desc = 'Neogit' },
    },
    opts = {
      disable_commit_confirmation = true,
      -- kind = 'floating',
      integrations = {
        diffview = true,
      },
      signs = {
        section = { '', '' },
        item = { '', '' },
        hunk = { '', '' },
      },
    },
  },
}
