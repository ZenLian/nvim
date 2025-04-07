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
    opts = {
      flavour = 'mocha',
      term_colors = true,
    },
    config = function(_, opts)
      local catppuccin = require('catppuccin')
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

      catppuccin.setup(opts)
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
    dependencies = { 'Zeioth/heirline-components.nvim' },
    event = 'UIEnter',
    config = function(_, opts)
      local heirline = require('heirline')
      local conditions = require('heirline.conditions')
      local lib = require('heirline-components.all')
      local C = require('catppuccin.palettes').get_palette(opts.flavour)

      lib.init.subscribe_to_events()
      heirline.load_colors(lib.hl.get_colors())

      local winbar = {
        init = function(self)
          self.bufnr = vim.api.nvim_get_current_buf()
        end,
        fallthrough = false,
        -- Winbar for inactive window
        {
          condition = function()
            return not lib.condition.is_active()
          end,
          {
            lib.component.neotree(),
            lib.component.fill(),
            lib.component.file_info { hl = { fg = C.subtext0 }, filename = {}, filetype = false },
            lib.component.aerial(),
          },
        },
        -- Regular winbar
        {
          lib.component.neotree(),
          lib.component.breadcrumbs(),
          lib.component.fill(),
          lib.component.file_info { filename = {}, filetype = false },
          lib.component.aerial(),
        },
      }

      local statusline = {
        lib.component.mode(),
        lib.component.file_info { filename = {}, filetype = false },
        lib.component.fill(),
        lib.component.cmd_info(),
        lib.component.lsp(),
        lib.component.git_branch(),
        lib.component.git_diff(),
        lib.component.nav {
          scrollbar = false,
        },
        lib.component.mode { surround = { separator = 'right' } },
      }

      heirline.setup {
        winbar = winbar,
        statusline = statusline,
        opts = {
          disable_winbar_cb = function(args)
            return conditions.buffer_matches({
              buftype = { 'nofile', 'help', 'quickfix', 'aerial', 'neo-tree' },
              filetype = { 'neo-tree', '^git.*' },
            }, args.buf)
          end,
        },
      }
    end,
  },
}
