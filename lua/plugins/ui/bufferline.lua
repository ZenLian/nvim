local spec = {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = { 'nvim-web-devicons' },
  event = { 'BufReadPre', 'BufNewFile' },
  opts = function()
    return {
      options = {
        -- separator_style = 'slant',
        offsets = {
          {
            filetype = 'neo-tree',
            text = '  Neo Tree',
            highlight = 'NeoTreeNormal',
            text_align = 'left',
          },
          {
            filetype = 'drex',
            text = '  Drex',
            highlight = 'NeoTreeNormal',
            text_align = 'left',
          },
        },
      },
      -- custom_filter = function(buf_number, buf_numbers)
      -- end
      -- themable = true,
    }
  end,
  config = function(_, opts)
    local bufferline = require('bufferline')
    local util = require('util')
    local C = require('catppuccin.palettes').get_palette()

    opts.highlights = require('catppuccin.groups.integrations.bufferline').get {
      -- styles = { 'italic' },
      custom = {
        all = {
          indicator_selected = { fg = C.blue, bg = C.base },
        },
      },
    }
    bufferline.setup(opts)

    util.keymaps {
      ['<S-h>'] = { '<cmd>lua require("bufferline").cycle(-1)<CR>', desc = 'Previous buffer' },
      ['<S-l>'] = { '<cmd>lua require("bufferline").cycle(1)<CR>', desc = 'Next buffer' },
      ['[b'] = { '<cmd>lua require("bufferline").cycle(-1)<CR>', desc = 'Previous buffer' },
      [']b'] = { '<cmd>lua require("bufferline").cycle(1)<CR>', desc = 'Next buffer' },
      ['[B'] = { '<cmd>lua require("bufferline").go_to_buffer(1, true)<cr>', desc = 'First buffer' },
      [']B'] = { '<cmd>lua require("bufferline").go_to_buffer(-1, true)<cr>', desc = 'Last buffer' },
      ['<A-,>'] = { '<cmd>BufferLineMovePrev<CR>', desc = 'Move buffer prev' },
      ['<A-.>'] = { '<cmd>BufferLineMoveNext<CR>', desc = 'Move buffer next' },
      ['<Leader>b'] = {
        b = { '<cmd>e #<CR>', desc = 'Last buffer' },
        g = { '<cmd>BufferLinePick<CR>', desc = 'Goto buffer' },
        p = { '<cmd>BufferLineTogglePin<CR>', desc = 'Pin/Unpin buffer' },
        c = { '<cmd>BufferLinePickClose<CR>', desc = 'Pick Close buffer+' },
        -- ['-'] = { 'Close other buffers' },
        ['['] = { '<cmd>BufferLineCloseLeft<CR>', desc = 'Close left buffers' },
        [']'] = { '<cmd>BufferLineCloseRight<CR>', desc = 'Close right buffers' },
        s = {
          n = { '<cmd>BufferLineSortByTabs<CR>', desc = 'Sort by name' },
          t = { '<cmd>BufferLineSortByExtension<CR>', desc = 'Sort by type' },
          d = { '<cmd>BufferLineSortByDirectory<CR>', desc = 'Sort by directory' },
        },
      },
    }
  end,
}

return { spec }
