require('config').setup()

-- try some new things here
return {
  'MunifTanjim/nui.nvim',
  'nvim-lua/plenary.nvim',
  'kkharji/sqlite.lua',
  {
    'echasnovski/mini.nvim',
    lazy = false,
    enabled = false,
    config = function()
      -- require('mini.pairs').setup()
      -- require('mini.animate').setup()
      -- require('mini.surround').setup {
      --   -- Module mappings. Use `''` (empty string) to disable one.
      --   mappings = {
      --     add = 'ys', -- Add surrounding in Normal and Visual modes
      --     delete = 'ds', -- Delete surrounding
      --     find = ']]', --'sf', -- Find surrounding (to the right)
      --     find_left = '[[', -- Find surrounding (to the left)
      --     highlight = '<cr>s', --'sh', -- Highlight surrounding
      --     replace = 'cs', -- Replace surrounding
      --     update_n_lines = '', --'sn', -- Update `n_lines`
      --
      --     suffix_last = 'l', -- Suffix to search with "prev" method
      --     suffix_next = 'n', -- Suffix to search with "next" method
      --   },
      -- }
      -- require('mini.move').setup()
    end,
  },
  {
    'zenlian/winddown.nvim',
    enabled = false,
    dev = true,
    lazy = false,
    -- event = 'VeryLazy',
    opts = {
      events = 'KeyPress',
    },
    keys = {
      {
        '<Space>zr',
        function()
          require('winddown').reset()
        end,
        desc = 'Reset winddown',
      },
    },
  },
}
