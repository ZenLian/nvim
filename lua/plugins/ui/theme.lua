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
  vim.g.catppuccin_flavour = 'mocha'
  local catppuccin = require('catppuccin')
  catppuccin.setup {
    transparent_background = false,
    term_colors = true,
    styles = {
      comments = 'italic',
      conditionals = 'italic',
      loops = 'NONE',
      functions = 'NONE',
      keywords = 'NONE',
      strings = 'NONE',
      variables = 'NONE',
      numbers = 'NONE',
      booleans = 'NONE',
      properties = 'NONE',
      types = 'NONE',
      operators = 'NONE',
    },
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = 'italic',
          hints = 'italic',
          warnings = 'italic',
          information = 'italic',
        },
        underlines = {
          errors = 'undercurl',
          hints = 'undercurl',
          warnings = 'undercurl',
          information = 'undercurl',
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
  }

  local c = require('catppuccin.api.colors').get_colors()
  catppuccin.remap {
    Search = { fg = c.surface1, bg = c.pink },
    Visual = { bg = c.surface1 },
    Pmenu = { fg = c.text, bg = c.surface0 },
    PmenuSel = { fg = c.surface0, bg = c.blue },
    CmpItemAbbr = { fg = c.text },
    CmpItemAbbrMatch = { fg = c.blue, style = 'bold' },
    CmpItemAbbrMatchFuzzy = { fg = c.blue, style = 'bold' },

    TelescopeNormal = { fg = c.text, bg = c.mantle },
    TelescopePromptNormal = { fg = c.text, bg = c.surface0 },
    TelescopePromptBorder = { fg = c.surface0, bg = c.surface0 },
    TelescopePromptTitle = { fg = c.blue },
    -- TelescopeSelection = { fg = c.mantle, bg = c.blue },
    TelescopeResultsBorder = { fg = c.mantle, bg = c.mantle },
    -- TelescopeResultsTitle = { fg = c.blue },
    TelescopePreviewNormal = { fg = c.text, bg = c.mantle },
    TelescopePreviewBorder = { fg = c.blue, bg = c.mantle },
    -- TelescopePreviewTitle = { fg = c.blue },
    TelescopeMatching = { fg = c.blue },

    NeogitHunkHeader = { bg = c.base, fg = c.blue },
    NeogitHunkHeaderHighlight = { bg = c.blue, fg = c.base },
  }

  vim.cmd([[colorscheme catppuccin]])
end

setup_catppuccin()
