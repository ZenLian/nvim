local spec = {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = { 'nvim-web-devicons' },
  event = 'UIEnter',
  keys = {
    { '<S-h>', '<cmd>lua require("bufferline").cycle(-1)<CR>', desc = 'Previous buffer' },
    { '<S-l>', '<cmd>lua require("bufferline").cycle(1)<CR>', desc = 'Next buffer' },
    { '[b', '<cmd>lua require("bufferline").cycle(-1)<CR>', desc = 'Previous buffer' },
    { ']b', '<cmd>lua require("bufferline").cycle(1)<CR>', desc = 'Next buffer' },
    { '[B', '<cmd>lua require("bufferline").go_to_buffer(1, true)<cr>', desc = 'First buffer' },
    { ']B', '<cmd>lua require("bufferline").go_to_buffer(-1, true)<cr>', desc = 'Last buffer' },
    { '<A-,>', '<cmd>BufferLineMovePrev<CR>' },
    { '<A-.>', '<cmd>BufferLineMoveNext<CR>' },
    -- b = {
    --   b = { '<cmd>e #<CR>', 'Last buffer' },
    --   -- d = { '<cmd>bd<CR>', 'Delete buffer' },
    --   d = { '<cmd>lua require("mini.bufremove").delete()<CR>', 'Delete buffer' },
    --   g = { '<cmd>BufferLinePick<CR>', 'Goto buffer' },
    --   p = { '<cmd>BufferLineTogglePin<CR>', 'Pin/Unpin buffer' },
    --   c = { '<cmd>BufferLinePickClose<CR>', 'Pick Close buffer+' },
    --   -- ['-'] = { 'Close other buffers' },
    --   ['['] = { '<cmd>BufferLineCloseLeft<CR>', 'Close left buffers' },
    --   [']'] = { '<cmd>BufferLineCloseRight<CR>', 'Close right buffers' },
    --   s = {
    --     name = 'sort',
    --     n = { '<cmd>BufferLineSortByTabs<CR>', 'Sort by name' },
    --     t = { '<cmd>BufferLineSortByExtension<CR>', 'Sort by type' },
    --     d = { '<cmd>BufferLineSortByDirectory<CR>', 'Sort by directory' },
    --   },
    -- },
  },
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
      highlights = require('catppuccin.groups.integrations.bufferline').get(),
      -- themable = true,
    }
  end,
}

return { spec }
