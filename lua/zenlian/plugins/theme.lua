---@type LazyPluginSpec[]
return {
  {
    'catppuccin/nvim',
    lazy = true,
    name = 'catppuccin',
    opts = function()
      local opts = {
        flavour = 'mocha',
        term_colors = true,
        integrations = {
          blink_cmp = true,
        },
      }
      local C = require('catppuccin.palettes').get_palette(opts.flavour)
      opts.custom_highlights = {
        -- Pmenu = { fg = C.text, bg = C.surface0 },
        -- PmenuSel = { fg = C.surface0, bg = C.blue },
        CmpItemAbbr = { fg = C.text },
        CmpItemAbbrMatch = { fg = C.blue, style = { 'bold' } },
        CmpItemAbbrMatchFuzzy = { fg = C.blue, style = { 'bold' } },
        -- BlinkCmpLabelMatch = { fg = C.blue, style = { 'bold' } },
        --

        -- flash.nvim
        FlashLabel = { fg = C.base, bg = C.green },
      }
      return opts
    end,
  },
}
