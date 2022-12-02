local M = {}

M.config = function()
  -- vim.g.catppuccin_flavour = 'latte'
  vim.g.catppuccin_flavour = 'mocha'
  -- vim.g.catppuccin_flavour = 'macchiato'
  local catppuccin = require('catppuccin')

  local colors = require('catppuccin.palettes').get_palette()

  catppuccin.setup {
    compile = {
      enabled = false,
      path = vim.fn.stdpath('cache') .. '/catppuccin',
    },
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
      MatchParen = { fg = colors.mantle, bg = colors.blue },

      Pmenu = { fg = colors.text, bg = colors.surface0 },
      PmenuSel = { fg = colors.surface0, bg = colors.blue },
      CmpItemAbbr = { fg = colors.text },
      CmpItemAbbrMatch = { fg = colors.blue, style = { 'bold' } },
      CmpItemAbbrMatchFuzzy = { fg = colors.blue, style = { 'bold' } },

      LspInfoBorder = { link = 'FloatBorder' },
      LspInfoTitle = { fg = colors.blue },
      LspInfoList = { fg = colors.green },
      LspInfoFiletype = { fg = colors.yellow },
      LspInfoTip = { link = 'Comment' },

      TelescopeNormal = { fg = colors.text, bg = colors.mantle },
      TelescopePromptNormal = { fg = colors.text, bg = colors.surface0 },
      TelescopePromptBorder = { fg = colors.surface0, bg = colors.surface0 },
      TelescopePromptTitle = { fg = colors.blue },
      TelescopeSelection = { fg = colors.text, bg = colors.surface1 },
      TelescopeResultsBorder = { fg = colors.mantle, bg = colors.mantle },
      -- TelescopeResultsTitle = { fg = c.blue },
      TelescopePreviewNormal = { fg = colors.text, bg = colors.mantle },
      TelescopePreviewBorder = { fg = colors.blue, bg = colors.mantle },
      -- TelescopePreviewTitle = { fg = c.blue },
      TelescopeMatching = { fg = colors.blue },

      NeoTreeNormalNC = { link = 'NeoTreeNormal' },

      NeogitHunkHeader = { bg = colors.base, fg = colors.blue },
      NeogitHunkHeaderHighlight = { bg = colors.blue, fg = colors.base },

      UfoFoldedBg = { bg = colors.surface1 },
    },
  }

  vim.cmd([[colorscheme catppuccin]])
end
return M
