local M = {}

function M.config()
  local palette = require('catppuccin.palettes').get_palette()
  require('nvim-web-devicons').setup {
    color_icons = true,
    default = true,
    override = {
      -- md = {
      --   icon = '',
      --   name = 'Md',
      -- },
      c = {
        icon = 'ﭰ',
        color = '#599eff',
        name = 'C',
      },
      cpp = {
        icon = 'ﭱ',
        color = '#519aba',
        name = 'Cpp',
      },
      cs = {
        icon = '',
        color = '#596706',
        name = 'Cs',
      },
    },
  }
  require('nvim-web-devicons').set_default_icon('', palette.text)
end

return M
