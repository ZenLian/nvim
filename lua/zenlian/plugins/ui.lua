-- Description: UI plugins
--
-- [catppuccin/nvim]: theme
-- [bufferline.nvim]: bufferline
-- [heirline.nvim]: statusline
return {
  {
    'catppuccin/nvim',
    lazy = true,
    name = 'catppuccin',
    opts = function()
      local opts = {
        flavour = 'mocha',
        term_colors = true,
      }
      local C = require('catppuccin.palettes').get_palette(opts.flavour)
      opts.custom_highlights = {
        -- Pmenu = { fg = C.text, bg = C.surface0 },
        -- PmenuSel = { fg = C.surface0, bg = C.blue },
        CmpItemAbbr = { fg = C.text },
        CmpItemAbbrMatch = { fg = C.blue, style = { 'bold' } },
        CmpItemAbbrMatchFuzzy = { fg = C.blue, style = { 'bold' } },
        BlinkCmpLabelMatch = { fg = C.blue, style = { 'bold' } },

        -- flash.nvim
        FlashLabel = { fg = C.base, bg = C.green },
      }
      return opts
    end,
  },

  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
      { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
      { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
      { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
    },
    opts = {
      options = {
        -- stylua: ignore
        close_command = function(n) Snacks.bufdelete(n) end,
        -- stylua: ignore
        right_mouse_command = function(n) Snacks.bufdelete(n) end,
        diagnostics = 'nvim_lsp',
        always_show_bufferline = false,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            highlight = 'Directory',
            text_align = 'left',
          },
          {
            filetype = 'snacks_layout_box',
          },
        },
      },
    },
  },

  {
    'rebelot/heirline.nvim',
    event = 'UIEnter',
    opts = function()
      local C = require('catppuccin.palettes').get_palette()
      return {
        colors = {
          fg = C.text,
          bg = C.base,
          black = C.base,
          red = C.red,
          green = C.green,
          yellow = C.yellow,
          blue = C.blue,
          purple = C.mauve,
          cyan = C.sky,
          white = C.text,
        },
      }
    end,
    config = function(_, opts)
      local heirline = require('heirline')
      local conditions = require('heirline.conditions')
      local lib = require('zenlian.util.heirline')

      lib.setup(opts)

      local statusline = {
        hl = { fg = 'fg', bg = 'bg' },
        lib.mode(),
        lib.space(),
        lib.filepath { relative = 'root' },
        lib.fileflags(),
        lib.space(),
        lib.git(),
        lib.align(),

        lib.lsp(),
        lib.space(),
        lib.ruler(),
        lib.space(),
        lib.mode(),
      }

      heirline.setup {
        -- winbar = winbar,
        statusline = statusline,
        opts = {
          disable_winbar_cb = function(args)
            return conditions.buffer_matches({
              buftype = { 'nofile', 'help', 'quickfix', 'aerial' },
              filetype = { 'neo-tree', '^git.*', 'fzf' },
            }, args.buf)
          end,
        },
      }
    end,
  },
}
