---@type LazyPluginSpec[]
return {

  {
    'sindrets/diffview.nvim',
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Open Diff View' },
      { '<leader>gD', '<cmd>DiffviewClose<cr>', desc = 'Close Diff View' },
    },
    ---@type DiffviewConfig
    opts = {
      keymaps = {
        view = {
          ['q'] = '<cmd>DiffviewClose<cr>',
        },
        file_panel = {
          ['q'] = '<cmd>DiffviewClose<cr>',
        },
        file_history_panel = {
          ['q'] = '<cmd>DiffviewClose<cr>',
        },
      },
      view = {
        merge_tool = {
          layout = 'diff3_mixed',
        },
      },
    },
  },

  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    cmd = 'Neogit',
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Neogit' },
    },
    opts = {
      disable_commit_confirmation = true,
      signs = {
        section = { '', '' },
        item = { '', '' },
        hunk = { '', '' },
      },
    },
  },
}
