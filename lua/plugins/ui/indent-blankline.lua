local spec = {
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufRead', 'BufNewFile' },
  -- enabled = false,
  opts = {
    -- show_current_context = true,
    -- show_current_context_start = true,
    show_trailing_blankline_indent = true,
    space_char_blankline = ' ',
    use_treesitter = true,
    filetype_exclude = {
      'help',
      'lsp-installer',
      'Trouble',
      'alpha',
      'aerial',
    },
  },
}

return { spec }
