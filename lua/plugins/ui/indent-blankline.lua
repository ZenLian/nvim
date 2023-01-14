local spec = {
  'lukas-reineke/indent-blankline.nvim',
  event = 'BufReadPre',
  opts = {
    show_current_context = true,
    -- show_current_context_start = true,
    show_trailing_blankline_indent = false,
    space_char_blankline = ' ',
    use_treesitter = true,
    filetype_exclude = {
      'help',
      'packer',
      'lsp-installer',
      'NvimTree',
      'Trouble',
      'undotree',
      'alpha',
      'aerial',
      'markdown',
    },
  },
}

return { spec }