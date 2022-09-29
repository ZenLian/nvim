-- vim.o.background = 'dark'
-- require('edgeme').setup {
--     style = 'aura',
-- }
-- vim.cmd [[colorscheme edgeme]]

-- vim.cmd([[colorscheme nvdark]])

-- require("themer").setup({
--     colorscheme = "tokyonight"
-- })

-- Lua:
-- For dark theme
-- vim.g.vscode_style = "dark"
-- For light theme
-- vim.g.vscode_style = "light"
-- Enable transparent background
-- vim.g.vscode_transparent = 0
-- Enable italic comment
-- vim.g.vscode_italic_comment = 1
-- Disable nvim-tree background color
-- vim.g.vscode_disable_nvimtree_bg = false
-- vim.cmd([[colorscheme vscode]])

local function setup_catppuccin()
  -- vim.g.catppuccin_flavour = 'latte'
  vim.g.catppuccin_flavour = 'mocha'
  local catppuccin = require('catppuccin')

  local colors = require('catppuccin.palettes').get_palette()

  catppuccin.setup {
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
      treesitter = true,
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
      coc_nvim = false,
      lsp_trouble = true,
      cmp = true,
      lsp_saga = false,
      gitgutter = false,
      gitsigns = true,
      telescope = true,
      nvimtree = {
        enabled = true,
        show_root = false,
        transparent_panel = false,
      },
      neotree = {
        enabled = false,
        show_root = false,
        transparent_panel = false,
      },
      which_key = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
      dashboard = true,
      neogit = true,
      vim_sneak = false,
      fern = false,
      barbar = false,
      bufferline = true,
      markdown = true,
      lightspeed = true,
      ts_rainbow = true,
      hop = false,
      notify = true,
      telekasten = false,
      symbols_outline = false,
    },
    custom_highlights = {
      Search = { fg = colors.surface1, bg = colors.pink },
      Visual = { bg = colors.surface1 },
      Pmenu = { fg = colors.text, bg = colors.surface0 },
      PmenuSel = { fg = colors.surface0, bg = colors.blue },
      CmpItemAbbr = { fg = colors.text },
      CmpItemAbbrMatch = { fg = colors.blue, style = { 'bold' } },
      CmpItemAbbrMatchFuzzy = { fg = colors.blue, style = { 'bold' } },

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

      NeogitHunkHeader = { bg = colors.base, fg = colors.blue },
      NeogitHunkHeaderHighlight = { bg = colors.blue, fg = colors.base },
    },
  }

  vim.cmd([[colorscheme catppuccin]])
end

setup_catppuccin()
