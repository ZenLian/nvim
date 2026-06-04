local util = require('zenlian.util')

util.on_vim_enter(function()
  vim.pack.add { 'https://github.com/MeanderingProgrammer/render-markdown.nvim' }

  require('render-markdown').setup {
    preset = 'obsidian',
    heading = {
      sign = false,
      icons = {},
    },
    code = {
      sign = false,
      width = 'block',
    },
  }

  Snacks.toggle({
    name = 'Render Markdown',
    get = require('render-markdown').get,
    set = require('render-markdown').set,
  }):map('<leader>\\m')
end)
