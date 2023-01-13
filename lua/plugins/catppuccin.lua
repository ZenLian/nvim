local spec = {
  'catppuccin/nvim',
  lazy = false,
  priority = 1000,
  name = 'catppuccin.nvim',
  dev = true,
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
    styles = {
      comments = { 'italic' },
      conditionals = { 'italic' },
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
      -- bufferline = true,
    },
    custom_highlights = {
      MatchParen = { fg = C.mantle, bg = C.blue },
      NormalFloat = { fg = C.text, bg = C.mantle },
      FloatBorder = { fg = C.blue, bg = C.mantle },

      Pmenu = { fg = C.text, bg = C.surface0 },
      PmenuSel = { fg = C.surface0, bg = C.blue },
      CmpItemAbbr = { fg = C.text },
      CmpItemAbbrMatch = { fg = C.blue, style = { 'bold' } },
      CmpItemAbbrMatchFuzzy = { fg = C.blue, style = { 'bold' } },

      DiagnosticHint = { fg = C.blue, style = { 'italic' } },
      DiagnosticSignHint = { fg = C.blue },
      DiagnosticFloatingHint = { fg = C.blue },

      LspInfoBorder = { link = 'FloatBorder' },
      LspInfoTitle = { fg = C.blue },
      LspInfoList = { fg = C.green },
      LspInfoFiletype = { fg = C.yellow },
      LspInfoTip = { link = 'Comment' },

      NullLsInfoBorder = { link = 'FloatBorder' },

      TelescopeNormal = { fg = C.text, bg = C.mantle },
      TelescopePromptNormal = { fg = C.text, bg = C.surface0 },
      TelescopePromptBorder = { fg = C.surface0, bg = C.surface0 },
      TelescopePromptTitle = { fg = C.blue },
      TelescopeSelection = { fg = C.text, bg = C.surface1 },
      TelescopeResultsBorder = { fg = C.mantle, bg = C.mantle },
      -- TelescopeResultsTitle = { fg = c.blue },
      TelescopePreviewNormal = { fg = C.text, bg = C.mantle },
      TelescopePreviewBorder = { fg = C.blue, bg = C.mantle },
      -- TelescopePreviewTitle = { fg = c.blue },
      TelescopeMatching = { fg = C.blue },

      -->leap.nvim {{{
      -- LeapMatch = { fg = C.base, bg = C.red },
      LeapLabelPrimary = { fg = C.base, bg = C.green },
      LeapLabelSecondary = { fg = C.base, bg = C.blue },
      -- LeapLabelSelected = { fg = C.base, bg = C.red },
      LeapBackdrop = { fg = C.surface2, bg = C.base },
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

      YankyPut = { link = 'IncSearch' },
      YankyYanked = { link = 'YankyPut' },

      UfoFoldedBg = { bg = C.surface0 },

      HydraRed = { fg = C.red, style = { 'bold' } },
      HydraBlue = { fg = C.blue, style = { 'bold' } },
      HydraAmaranth = { fg = C.mauve, style = { 'bold' } },
      HydraPink = { fg = C.pink, style = { 'bold' } },
      HydraTeal = { fg = C.teal, style = { 'bold' } },

      BqfPreviewFloat = { link = 'NormalFloat' },
      BqfPreviewBorder = { link = 'TelescopePreviewBorder' },
    },
  }

  vim.cmd([[colorscheme catppuccin]])

  -- TODO: move to somewhere else
  -- set winheighlight
  local util = require('util')
  util.augroup {
    ['vimrc.theme'] = {
      desc = 'Set winheighlight',
      event = { 'FileType' },
      pattern = {
        'qf',
      },
      command = [[setlocal winhl=Normal:NormalFloat,NormalNC:NormalFloat]],
    },
  }
end

return { spec }
