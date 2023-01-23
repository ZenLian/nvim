local spec = {
  'stevearc/oil.nvim',
  lazy = false,
  keys = {
    {
      '-',
      function()
        require('oil').open()
      end,
      desc = 'Open parent directory',
    },
    {
      '<Leader>d',
      function()
        require('oil').open(vim.fn.getcwd())
      end,
      desc = 'Open CWD',
    },
    {
      '<Leader>D',
      function()
        require('oil').open_float(vim.fn.getcwd())
      end,
      desc = 'Open CWD in float',
    },
  },
  config = function()
    require('oil').setup {
      win_options = {
        winhl = 'Normal:NormalFloat,NormalNC:NormalFloat',
      },
      -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
      -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
      -- Additionally, if it is a string that matches "actions.<name>",
      -- it will use the mapping at require("oil.actions").<name>
      -- Set to `false` to remove a keymap
      -- See :help oil-actions for a list of all available actions
      keymaps = {
        ['g?'] = 'actions.show_help',
        ['<CR>'] = 'actions.select',
        ['<Tab>'] = 'actions.select',
        ['<C-h>'] = false,
        ['<C-s>'] = 'actions.select_split',
        ['<C-v>'] = 'actions.select_vsplit',
        ['<C-p>'] = 'actions.preview',
        ['<C-c>'] = 'actions.close',
        ['<C-l>'] = false,
        ['<Leader>r'] = 'actions.refresh',
        ['-'] = 'actions.parent',
        ['_'] = 'actions.open_cwd',
        ['`'] = 'actions.cd',
        ['~'] = 'actions.tcd',
        ['g.'] = 'actions.toggle_hidden',
      },
      view_options = {
        show_hidden = true,
      },
      float = {
        -- padding = 10,
        max_width = 80,
        max_height = 120,
        border = 'single',
        win_options = {
          winblend = 0,
        },
      },
    }
  end,
}

return { spec }
