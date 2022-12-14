local config = function()
  require('which-key').setup {
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
end

return {
  config = config,
}
