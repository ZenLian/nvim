return {
  {
    'nvim-lualine/lualine.nvim',
    enabled = false,
  },
  {
    'rebelot/heirline.nvim',
    event = 'UIEnter',
    opts = function()
      local C = require('catppuccin.palettes').get_palette()
      return {
        colors = C,
      }
    end,
    config = function(_, opts)
      require('heirline').load_colors(opts.colors)
      local conditions = require('heirline.conditions')
      local components = require('util').heirline

      local defaultStatusline = {
        components.mode('█  '),
        components.root_dir { cwd = true, color = 'pink' },
        components.filetype { icon_only = true },
        components.filepath { modified_color = 'green' },
        components.fileflags {},
        components.trim,
        components.align,

        components.noice_command { color = 'mauve' },
        components.noice_mode { color = 'peach' },
        components.lazy_status { color = 'maroon' },
        components.git {},
        components.ruler { color = 'subtext0' },
        components.mode('█'),
      }

      local alphaStatusline = {
        condition = function()
          return conditions.buffer_matches {
            filetype = { 'alpha', 'dashboard', 'starter' },
          }
        end,
        components.mode('█  '),
        {
          provider = function()
            return vim.bo.filetype
          end,
        },
        components.align,
        components.nvim_version(),
        components.mode('█'),
      }

      local neotreeStatusline = {
        condition = function()
          return vim.tbl_contains({ 'neo-tree' }, vim.bo.filetype)
        end,
        components.mode('█ 󰝰 '),
        components.workdir { color = 'pink' },
        components.align,
        components.mode('█'),
      }

      local statusline = {
        hl = { fg = 'text', bg = 'base' },
        fallthrough = false,
        alphaStatusline,
        neotreeStatusline,
        defaultStatusline,
      }

      require('heirline').setup {
        statusline = statusline,
      }
    end,
  },
}
