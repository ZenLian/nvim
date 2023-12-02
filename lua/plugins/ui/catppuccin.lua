local spec = {
  'catppuccin/nvim',
  lazy = false,
  priority = 1000,
  name = 'catppuccin.nvim',
  -- dev = true,
}

spec.config = function()
  -- vim.g.catppuccin_flavour = 'latte'
  vim.g.catppuccin_flavour = 'mocha'
  -- vim.g.catppuccin_flavour = 'macchiato'
  local catppuccin = require('catppuccin')

  local C = require('catppuccin.palettes').get_palette()

  catppuccin.setup {
    -- compile = {
    --   enabled = false,
    --   path = vim.fn.stdpath('cache') .. '/catppuccin',
    -- },
    transparent_background = false,
    term_colors = true,
    -- no_italic = true,
    styles = {
      comments = { 'italic' },
      conditionals = {},
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    integrations = {
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { 'italic' },
          hints = { 'italic' },
          warnings = { 'italic' },
          information = { 'italic' },
        },
        underlines = {
          errors = { 'undercurl' },
          hints = { 'undercurl' },
          warnings = { 'undercurl' },
          information = { 'undercurl' },
        },
      },
      aerial = false,
      cmp = true,
      gitsigns = true,
      illuminate = true,
      leap = true,
      lsp_trouble = true,
      markdown = true,
      mason = true,
      neogit = true,
      neotree = true,
      notify = true,
      nvimtree = false,
      telescope = true,
      treesitter = true,
      treesitter_context = true,
      ts_rainbow = true,
      which_key = true,

      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
    },
    custom_highlights = {
      -- MatchParen = { fg = C.mantle, bg = C.blue },
      NormalFloat = { fg = C.text, bg = C.mantle },
      FloatBorder = { fg = C.blue, bg = C.mantle },
      OnYank = { fg = C.base, bg = C.teal },

      Pmenu = { fg = C.text, bg = C.surface0 },
      PmenuSel = { fg = C.surface0, bg = C.blue },
      CmpItemAbbr = { fg = C.text },
      CmpItemAbbrMatch = { fg = C.blue, style = { 'bold' } },
      CmpItemAbbrMatchFuzzy = { fg = C.blue, style = { 'bold' } },

      DiagnosticHint = { fg = C.blue, style = { 'italic' } },
      DiagnosticSignHint = { fg = C.blue },
      DiagnosticFloatingHint = { fg = C.blue },

      -- FIX: Is there any better way to disable all italics for treesitter?
      ['@parameter'] = { fg = C.maroon, style = {} }, -- For parameters of a function.
      ['@namespace'] = { fg = C.lavender, style = {} }, -- For identifiers referring to modules and namespaces.
      ['@text.emphasis'] = { fg = C.maroon, style = {} }, -- italic
      ['@text.uri'] = { fg = C.rosewater, style = { 'underline' } }, -- urls, links and emails
      ['@tag.attribute'] = { fg = C.teal, style = {} }, -- Tags like html tag names.

      LspInfoBorder = { link = 'FloatBorder' },
      LspInfoTitle = { fg = C.blue },
      LspInfoList = { fg = C.green },
      LspInfoFiletype = { fg = C.yellow },
      LspInfoTip = { link = 'Comment' },

      NullLsInfoBorder = { link = 'FloatBorder' },

      -- TelescopeNormal = { fg = C.text, bg = C.mantle },
      -- TelescopePromptNormal = { fg = C.text, bg = C.surface0 },
      TelescopePromptBorder = { fg = C.blue, bg = C.base },
      TelescopePromptTitle = { fg = C.blue, bg = C.base },
      -- TelescopeSelection = { fg = C.text, bg = C.surface1 },
      TelescopeResultsBorder = { fg = C.blue, bg = C.base },
      TelescopeResultsTitle = { fg = C.blue, bg = C.base },
      -- TelescopePreviewNormal = { fg = C.text, bg = C.mantle },
      TelescopePreviewBorder = { fg = C.blue, bg = C.base },
      TelescopePreviewTitle = { fg = C.blue, bg = C.base },
      -- TelescopeMatching = { fg = C.blue },

      -->leap.nvim {{{
      -- LeapMatch = { fg = C.base, bg = C.red },
      LeapLabelPrimary = { fg = C.base, bg = C.green },
      LeapLabelSecondary = { fg = C.base, bg = C.blue },
      -- LeapLabelSelected = { fg = C.base, bg = C.red },
      -- LeapBackdrop = { fg = C.surface1, bg = C.base },
      -- }}}

      -->flash.nvim {{{
      FlashLabel = { fg = C.base, bg = C.green },
      -- }}}

      -->nvim-treehopper {{{
      TSNodeUnmatched = { fg = C.surface2, bg = C.base, style = {} },
      TSNodeKey = { fg = C.base, bg = C.green },
      -- }}}

      NeoTreeNormalNC = { link = 'NeoTreeNormal' },

      DrexMarked = { fg = C.base, bg = C.red },
      DrexSelected = { link = 'Substitute' },

      NeogitHunkHeader = { bg = C.base, fg = C.blue },
      NeogitHunkHeaderHighlight = { bg = C.blue, fg = C.base },
      -- NeogitNotificationInfo = { fg = C.green },
      -- NeogitNotificationWarning = { fg = C.yellow },
      -- NeogitNotificationError = { fg = C.red },

      YankyPut = { link = 'OnYank' },
      YankyYanked = { link = 'YankyPut' },

      UfoFoldedBg = { bg = C.surface0 },

      HydraRed = { fg = C.red, style = { 'bold' } },
      HydraBlue = { fg = C.blue, style = { 'bold' } },
      HydraAmaranth = { fg = C.mauve, style = { 'bold' } },
      HydraPink = { fg = C.pink, style = { 'bold' } },
      HydraTeal = { fg = C.teal, style = { 'bold' } },

      BqfPreviewFloat = { link = 'NormalFloat' },
      BqfPreviewBorder = { link = 'TelescopePreviewBorder' },

      MiniIndentscopeSymbol = { fg = C.text },
      MiniStarterCurrent = { link = 'CursorLine' },
      MiniStarterHeader = { fg = C.blue },
      MiniStarterFooter = { fg = C.overlay1 },
      -- MiniStarterInactive = { link='Normal'},
      -- MiniStarterItem = { link='Normal'},
      MiniStarterItemBullet = { fg = C.overlay1 },
      MiniStarterItemPrefix = { fg = C.blue },
      MiniStarterSection = { fg = C.mauve },
      MiniStarterQuery = { fg = C.blue },
    },
  }

  vim.cmd([[colorscheme catppuccin]])
end

return { spec }
