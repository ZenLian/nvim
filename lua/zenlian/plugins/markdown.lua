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
  completions = {
    lsp = { enabled = true },
  },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown' },
  callback = function(ev)
    Snacks.toggle({
      name = 'Render Markdown',
      get = require('render-markdown').get,
      set = require('render-markdown').set,
    }):map('<leader>\\m', { buf = ev.buf })
  end,
})
