-- event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
vim.g.rainbow_delimiters = {
  strategy = {
    -- Disabled for very large files
    [''] = function(bufnr)
      local lines = vim.api.nvim_buf_line_count(bufnr)
      if lines > 10000 then
        return nil
      else
        return 'rainbow-delimiters.strategy.global'
      end
    end,
  },
  query = {
    [''] = 'rainbow-delimiters',
  },
  highlight = {
    'RainbowDelimiterRed',
    'RainbowDelimiterYellow',
    'RainbowDelimiterBlue',
    'RainbowDelimiterOrange',
    -- 'RainbowDelimiterGreen',
    'RainbowDelimiterViolet',
    'RainbowDelimiterCyan',
  },
}

vim.pack.add({
  "https://github.com/hiphish/rainbow-delimiters.nvim",
})
