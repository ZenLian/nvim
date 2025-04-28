---@module 'lazy'
---@type LazyPluginSpec[]
return {
  {
    'ibhagwan/fzf-lua',
    -- cmd = 'FzfLua',
    event = 'VeryLazy',
    keys = {
      -- resume
      { '<leader><space>', '<cmd>FzfLua resume<cr>', desc = 'Resume picker' },
      -- find files
      {
        '<leader>ff',
        function()
          require('fzf-lua').files()
        end,
        desc = 'Find Files (Root Dir)',
      },
      {
        '<C-p>',
        function()
          require('fzf-lua').files { previewer = false, winopts = { width = 0.60 } }
        end,
        desc = 'Find Files (Root Dir)',
      },
      { '<leader>fo', '<cmd>FzfLua oldfiles<cr>', desc = 'Old Files' },
      { '<leader>fG', '<cmd>FzfLua git_files<cr>', desc = 'Git Files' },
      { '<leader>fb', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>', desc = 'Buffers' },

      -- greps
      { '<leader>fg', '<cmd>FzfLua live_grep<cr>', desc = 'Grep (CWD)' },
      { '<leader>fw', '<cmd>FzfLua grep_cword<cr>', desc = 'Current Word (CWD)' },
      { '<leader>fw', '<cmd>FzfLua grep_visual<cr>', mode = 'v', desc = 'Selection (CWD)' },

      -- misc
      { '<leader>s"', '<cmd>FzfLua registers<cr>', desc = 'Registers' },
      { '<leader>sH', '<cmd>FzfLua highlights<cr>', desc = 'Highlights' },
      { '<leader>sK', '<cmd>FzfLua keymaps<cr>', desc = 'Keymaps' },
      { '<leader>sM', '<cmd>FzfLua manpages<cr>', desc = 'Manpages' },
      { '<leader>sC', '<cmd>FzfLua colorschemes<cr>', desc = 'Colorschemes' },
    },
    opts = function()
      local Util = require('zenlian.util')
      local opts = {
        nbsp = '\xc2\xa0',
        keymap = {
          builtin = {
            true,
            ['<c-f>'] = 'preview-page-down',
            ['<c-b>'] = 'preview-page-up',
          },
          fzf = {
            true,
            ['ctrl-u'] = 'half-page-down',
            ['ctrl-d'] = 'half-page-up',
            ['ctrl-f'] = 'preview-page-down',
            ['ctrl-b'] = 'preview-page-up',
          },
        },
        actions = {
          files = {
            true, -- uncomment to inherit all the below in your custom config
            ['ctrl-x'] = Util.lazy.has('trouble.nvim') and require('trouble.sources.fzf').actions.open or nil,
          },
        },
      }
      return opts
    end,
    config = function(_, opts)
      require('fzf-lua').setup(opts)
      require('fzf-lua').register_ui_select {
        winopts = {
          width = 0.60,
        },
      }
    end,
  },
}
