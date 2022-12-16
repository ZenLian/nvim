local M = {
  packer = {},
}

M.packer.config = function()
  local wk = require('which-key')
  wk.setup {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = true,
        text_objects = true,
        nav = false,
        z = true,
        g = false,
      },
    },
    icons = {
      breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
      separator = '➜', -- symbol used between a key and it's label
      group = '+', -- symbol prepended to a group
    },
    window = {
      winblend = 3,
    },
    show_help = false,
  }

  wk.register({
    g = { name = 'git', {} },
    z = { name = 'zen', {} },
  }, { prefix = '<Leader>' })
end

return M
