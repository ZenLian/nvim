-- vim:foldmethod=marker:foldmarker={{{,}}}:

require('config').setup()

local plugins = {
  -- TODO: maybe dont need it anymore with lazy.nvim
  -- ['lewis6991/impatient.nvim'] = {},

  ['RRethy/vim-illuminate'] = 'illuminate',

  ['nvim-telescope/telescope-file-browser.nvim'] = {
    after = 'telescope.nvim',
    config = function()
      require('telescope').load_extension('file_browser')
    end,
  },

  ['gbprod/yanky.nvim'] = 'yanky',
  ['akinsho/toggleterm.nvim'] = 'toggleterm',
  ['folke/todo-comments.nvim'] = 'todo-comments',
  ['abecodes/tabout.nvim'] = {
    after = { 'nvim-cmp', 'nvim-treesitter' },
    config = function()
      require('tabout').setup {}
    end,
  },

  ['ray-x/lsp_signature.nvim'] = { module = 'lsp_signature' },
  ['stevearc/aerial.nvim'] = 'aerial',
  ['folke/trouble.nvim'] = {
    requires = 'kyazdani42/nvim-web-devicons',
    cmd = 'Trouble',
    module = 'trouble',
    config = function()
      require('trouble').setup {
        autoclose = true,
      }
    end,
  },
  -- }}} lsp

  --- always trying something new {{{
  ['kevinhwang91/nvim-bqf'] = 'bqf',
  ['cbochs/grapple.nvim'] = 'grapple',
  --- }}}
}

-- try some new things here
return {
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
}
