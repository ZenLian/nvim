---@type LazyPluginSpec[]
return {
  {
    'rebelot/heirline.nvim',
    event = 'UIEnter',
    opts = function()
      local C = require('catppuccin.palettes').get_palette()
      return {
        colors = {
          fg = C.text,
          bg = C.base,
          black = C.base,
          red = C.red,
          green = C.green,
          yellow = C.yellow,
          blue = C.blue,
          purple = C.mauve,
          cyan = C.sky,
          white = C.text,
        },
      }
    end,
    config = function(_, opts)
      local heirline = require('heirline')
      local conditions = require('heirline.conditions')
      local lib = require('zenlian.util.heirline')

      lib.setup(opts)

      local defaultStatusline = {
        lib.mode(),
        lib.space(),
        lib.filepath { relative = 'root' },
        lib.fileflags(),
        lib.space(),
        lib.git(),
        lib.align(),

        lib.showcmd(),
        lib.space(),
        lib.lsp(),
        lib.space(),
        lib.diagnostics(),
        lib.space(),
        lib.ruler(),
        lib.space(),
        lib.mode(),
      }

      local neotreeStatusline = {
        condition = function()
          return conditions.buffer_matches {
            filetype = { 'neo%-tree', 'oil' },
          }
        end,
        lib.mode(),
        lib.space(),
        lib.neotree(),
        lib.oil(),
        lib.align(),

        lib.ruler(),
        lib.space(),
        lib.mode(),
      }

      local helpStatusline = {
        condition = function()
          return conditions.buffer_matches {
            filetype = { 'fzf', 'trouble' },
            buftype = { 'help', 'quickfix' },
          }
        end,
        lib.mode(),
        lib.space(),
        {
          condition = function()
            return conditions.buffer_matches {
              buftype = { 'help' },
            }
          end,
          provider = function()
            return vim.fn.expand('%:t:r')
          end,
        },
        {
          provider = function()
            return '[' .. vim.bo.filetype .. ']'
          end,
        },
        lib.align(),
        lib.ruler(),
        lib.space(),
        lib.mode(),
      }

      local statuslines = {
        hl = { fg = 'fg', bg = 'bg' },
        fallthrough = false,
        helpStatusline,
        neotreeStatusline,
        defaultStatusline,
      }

      local winbar = {
        hl = { fg = 'fg', bg = 'bg' },
        fallthrough = false,
        lib.oil(),
      }

      heirline.setup {
        winbar = winbar,
        statusline = statuslines,
        opts = {
          disable_winbar_cb = function(args)
            -- return conditions.buffer_matches({
            --   buftype = { 'nofile', 'help', 'quickfix', 'aerial' },
            --   filetype = { 'neo-tree', '^git.*', 'fzf' },
            -- }, args.buf)
            -- only show in some buffers
            return not conditions.buffer_matches({ filetype = { 'oil' } }, args.buf)
          end,
        },
      }
    end,
  },
}
