vim.pack.add {
  {
    src = 'https://github.com/olimorris/codecompanion.nvim',
    version = vim.version.range('^19.0.0'),
  },
}

require('codecompanion').setup {
  -- looking for env variable: $DEEPSEEK_API_KEY
  interactions = {
    chat = {
      adapter = 'deepseek',
      model = 'deepseek-v4-flash',
    },
    inline = {
      adapter = 'deepseek',
      model = 'deepseek-v4-pro',
    },
  },
  opts = {
    log_level = 'INFO',
    language = 'chinese',
  },
}
