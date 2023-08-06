local config = require("config")

local spec = {
  'nvim-tree/nvim-web-devicons',
  cond = config.icons.enabled,
}

spec.config = function()
  require('nvim-web-devicons').setup {
    color_icons = true,
    default = true,
    override = {
      md = {
        icon = '',
        color = '#519aba',
        name = 'Md',
      },
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
  local palette = require('catppuccin.palettes').get_palette()
  require('nvim-web-devicons').set_default_icon('', palette.text)
end

return { spec }
