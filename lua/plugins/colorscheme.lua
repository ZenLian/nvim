return {
  -- disable tokyonight
  {
    'folke/tokyonight.nvim',
    enabled = false,
  },
  -- add catppuccin
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    opts = {
      flavour = 'mocha',
      term_colors = true,
    },
    config = function(_, opts)
      local catppuccin = require('catppuccin')
      local C = require('catppuccin.palettes').get_palette(opts.flavour)
      opts.custom_highlights = {
        Pmenu = { fg = C.text, bg = C.surface0 },
        PmenuSel = { fg = C.surface0, bg = C.blue },
        CmpItemAbbr = { fg = C.text },
        CmpItemAbbrMatch = { fg = C.blue, style = { 'bold' } },
        CmpItemAbbrMatchFuzzy = { fg = C.blue, style = { 'bold' } },

        -- flash.nvim
        FlashLabel = { fg = C.base, bg = C.green },
      }

      catppuccin.setup(opts)
    end,
  },
  -- set colorscheme
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'catppuccin',
    },
  },
}
